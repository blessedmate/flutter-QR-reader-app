import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader_app/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
    );

    // Markers
    Set<Marker> markers = <Marker>{};
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_searching_outlined),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: scan.getLatLng(),
                zoom: 17.5,
              )));
            },
          )
        ],
      ),
      body: GoogleMap(
        markers: markers,
        mapType: mapType,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.layers),
        onPressed: () {
          mapType == MapType.normal
              ? mapType = MapType.satellite
              : mapType = MapType.normal;

          setState(() {});
        },
      ),
    );
  }
}
