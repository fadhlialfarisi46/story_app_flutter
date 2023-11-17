/*
 * *
 *  * Created by fadhlialfarisi on 11/17/23, 2:30 PM
 *  * Copyright (c) 2023 . All rights reserved.
 *  * Last modified 11/17/23, 2:30 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

class PlacemarkWidget extends StatefulWidget {
  final Function onSetLocation;

  const PlacemarkWidget({
    super.key,
    required this.placemark,
    required this.onSetLocation,
  });

  final geo.Placemark placemark;

  @override
  State<PlacemarkWidget> createState() => _PlacemarkWidgetState();
}

class _PlacemarkWidgetState extends State<PlacemarkWidget> {
  String location = "";

  @override
  Widget build(BuildContext context) {
    location =
        "${widget.placemark.subLocality}, ${widget.placemark.locality}, ${widget.placemark.postalCode}, ${widget.placemark.country}";

    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  location,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget
                        .onSetLocation("${widget.placemark.street!} $location");
                  },
                  child: const Text("Set as my location"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
