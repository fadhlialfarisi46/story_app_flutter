/*
 * *
 *  * Created by fadhlialfarisi on 11/9/23, 8:22 AM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/9/23, 8:22 AM
 *
 */
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app_flutter/data/preference/auth_preference.dart';

import '../common/state_management.dart';
import '../data/api_service/api_service.dart';
import '../data/model/story.dart';
import '../provider/detail_story_provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailStoryPage extends StatefulWidget {
  final String id;
  final Function() onBack;

  const DetailStoryPage({super.key, required this.id, required this.onBack});

  @override
  State<DetailStoryPage> createState() => _DetailStoryPageState();
}

class _DetailStoryPageState extends State<DetailStoryPage> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailStoryProvider>(
      create: (_) => DetailStoryProvider(
          apiService: ApiService(),
          id: widget.id,
          authPreference: AuthPreference()),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<DetailStoryProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.state == ResultState.success) {
              final story = state.result.story;
              // print(story.lat.toString());
              // if (story.lat != null && story.lat != null) {
              //   final marker = Marker(
              //     markerId: const MarkerId("detail"),
              //     position: LatLng(story.lat!, story.lon!),
              //     infoWindow: InfoWindow(
              //       title: "${story.lat} ${story.lon}",
              //     ),
              //   );
              //   markers.add(marker);
              // }

              return _buildDetailBody(context, story);
            }

            return Center(
              child: Text(state.message),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDetailBody(BuildContext context, Story story) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(story.photoUrl),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  story.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  story.createdAt.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  story.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (story.lat != null && story.lon != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 200,
                      child: GoogleMap(
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(story.lat!, story.lon!),
                          zoom: 18,
                        ),
                        onMapCreated: (controller) async {
                          final info = await geo.placemarkFromCoordinates(
                              story.lat!, story.lon!);

                          final place = info[0];
                          final street = place.street!;
                          final address =
                              '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                          defineMarker(
                              LatLng(story.lat!, story.lon!), street, address);

                          setState(() {
                            mapController = controller;
                          });
                        },
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildHeader(String urlImage) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Image.network(
              urlImage,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 8.0,
            )
          ],
        ),
        Positioned(
          left: 8,
          top: 8,
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.8),
            child: IconButton(
                onPressed: () {
                  widget.onBack();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
