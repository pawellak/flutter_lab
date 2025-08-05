import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:places_app/widgets/image_inputs.dart';
import 'package:places_app/widgets/location_inputs.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lnb)
  {
    _pickedLocation=PlaceLocation(latitude: lat, longitude: lnb, address: '');
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || (_pickedImage == null||_pickedLocation==null)) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage,_pickedLocation!);
    Navigator.of(context).pop(PlacesListScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Column buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [buildTitleFieldAndImage(), buildAddPlaceButton()],
    );
  }

  ElevatedButton buildAddPlaceButton() {
    return ElevatedButton.icon(
      onPressed: () => _savePlace(),
      icon: const Icon(Icons.add),
      label: const Text('Add Place'),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          primary: Theme.of(context).colorScheme.secondary,
          onPrimary: Colors.black),
    );
  }

  Expanded buildTitleFieldAndImage() {
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'title'),
              controller: _titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInputs(onSelectImage: _selectImage),
            const SizedBox(
              height: 10,
            ),
             LocationInput(onSelectPlace: _selectPlace),
          ],
        ),
      ),
    ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Add a new place'),
    );
  }
}
