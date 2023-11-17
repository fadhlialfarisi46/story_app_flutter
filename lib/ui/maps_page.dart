/*
 * *
 *  * Created by fadhlialfarisi on 11/15/23, 9:17 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/15/23, 9:17 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app_flutter/data/model/story.dart';
import 'package:story_app_flutter/provider/maps_provider.dart';

import '../common/state_management.dart';

class MapsPage extends StatefulWidget {
  final Function onBack;

  const MapsPage({super.key, required this.onBack});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  final tourismPlaces = const [
    LatLng(-6.8168954, 107.6151046),
    LatLng(-6.8331128, 107.6048483),
    LatLng(-6.8668408, 107.608081),
    LatLng(-6.9218518, 107.6025294),
    LatLng(-6.780725, 107.637409),
  ];

  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    // final marker = Marker(
    //   markerId: const MarkerId("dicoding"),
    //   position: dicodingOffice,
    //   onTap: () {
    //     mapController.animateCamera(
    //       CameraUpdate.newLatLngZoom(dicodingOffice, 18),
    //     );
    //   },
    // );
    // markers.add(marker);
    //
    // addManyMarker();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onBack();
          },
        ),
      ),
      body: Consumer<MapsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.state == ResultState.success) {
            addManyMarker(state.result.listStory);

            return _buildMaps(state.result.listStory);
          }

          return Center(
            child: Text(state.message),
          );
        },
      ),
      // _buildMaps(),
    );
  }

  Center _buildMaps(List<Story> listStory) {
    return Center(
      child: GoogleMap(
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: dicodingOffice,
        ),
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });

          final bound = boundsFromLatLngList(listStory.map((data) {
            return LatLng(data.lat ?? 0, data.lon ?? 0);
          }).toList());
          mapController.animateCamera(
            CameraUpdate.newLatLngBounds(bound, 50),
          );
        },
      ),
    );
  }

  void addManyMarker(List<Story> listStory) {
    for (var story in listStory) {
      final position = LatLng(story.lat ?? 0, story.lon ?? 0);
      markers.add(
        Marker(
          markerId: MarkerId(story.id),
          position: position,
          infoWindow: InfoWindow(
            title: story.name,
          ),
          onTap: () {
            mapController.animateCamera(
              CameraUpdate.newLatLngZoom(position, 18),
            );
            _showBottomSheetDialog(story);
          },
        ),
      );
    }
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  void _showBottomSheetDialog(Story story) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Detail Story",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Expanded(child: _buildDetailBody(story)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailBody(Story story) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            story.photoUrl,
            width: 250,
            height: 200,
          ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
