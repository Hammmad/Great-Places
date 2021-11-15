import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:great_places/providers/places_provider.dart';
import 'package:great_places/widget/image_input.dart';
import 'package:great_places/widget/location_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  static const String routeName = '/add-products';

  @override
  _AddPlacesScreenState createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {

  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace(){
    if(_titleController.text.isEmpty || _pickedImage==null){
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false).addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
    print('Button has been pressed');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                    controller: _titleController,
                  ),
                  const SizedBox(width: 0, height: 10,),
                 ImageInput(_selectImage),
                  const SizedBox(width: 0, height: 10,),
                  LocationInput(),
                ],
              ),
            ),
            RaisedButton.icon(
                onPressed: () {
                  _savePlace();
                },
                elevation: 0,
                color: Theme.of(context).primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                icon: Icon(Icons.save),
                label: Text('Submit')
                ),
          ],
        ),
      ),
    );
  }
}
