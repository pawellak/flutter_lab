import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key? key,
      this.initialLocation = const PlaceLocation(
          latitude: 52.53, longitude: 21.09, address: 'text'),
      this.isSelecting = false})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                    position: _pickedLocation ??
                        LatLng(widget.initialLocation.latitude,
                            widget.initialLocation.longitude),
                    markerId: const MarkerId('m1'))
              },
        onTap: widget.isSelecting ? _selectLocation : null,
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude)),
      ),
      appBar: AppBar(
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: const Icon(Icons.check))
        ],
        title: const Text('Your Map'),
      ),
    );
  }
}
