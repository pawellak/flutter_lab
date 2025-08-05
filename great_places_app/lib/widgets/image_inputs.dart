import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_path;

class ImageInputs extends StatefulWidget {
  final Function onSelectImage;

  const ImageInputs({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputsState createState() => _ImageInputsState();
}

class _ImageInputsState extends State<ImageInputs> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final Directory appDir = await sys_path.getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFile.path);
    await imageFile.saveTo('${appDir.path}/$fileName');
    widget.onSelectImage(File(imageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [buildImage(), const SizedBox(width: 10), takeAPicture()],
    );
  }

  Expanded takeAPicture() {
    return Expanded(

        child: SizedBox(
          height: 134,
          child: TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text('Take picture'),
    ),
        ));
  }

  Container buildImage() {
    return Container(
      child: _storedImage != null
          ? Image.file(
              _storedImage!,
        fit: BoxFit.fill,
            )
          : const Text(
              'No image Taken',
              textAlign: TextAlign.center,
            ),
      alignment: Alignment.center,
      height: 134,
      width: 100,
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
    );
  }
}
