import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as system_path;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;


  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

 File? _storedImage;

  Future<XFile?> _takePicture() async {
    final  image = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 600);

    setState(() {
      _storedImage = File(image!.path);
    });

    final Directory appDir = await system_path.getApplicationDocumentsDirectory();
    final imageFileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$imageFileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.grey, width: 2.0)),
          child: _storedImage != null
          ? Image.file(File(_storedImage!.path), width: double.infinity, fit: BoxFit.cover,)
          : const Text('No Image selected',
          textAlign: TextAlign.center,),
        ),
        const SizedBox(width: 10,),
        Expanded(child: FlatButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take Shot')))
      ],
    );
  }
}
