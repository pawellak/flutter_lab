import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({Key? key, required this.onSelectPlace})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final previewUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);

    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      _showPreview(location.latitude!, location.longitude!);
      widget.onSelectPlace(location.latitude, location.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const MapScreen(isSelecting: true),
    ));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Center(
                  child: Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                ))
              : Image.network(_previewImageUrl!,
                  fit: BoxFit.fill, width: double.infinity),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
              label: const Text('Current Location'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: _selectOnMap,
              label: const Text('Select on Map'),
            )
          ],
        ),
      ],
    );
  }
}
