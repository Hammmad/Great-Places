import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _myCurrentLocation() async {
    final myLocation = await Location().getLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration:  BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: Colors.grey, width: 2.0)),
          child: _previewImageUrl == null
          ?const Text('No location chosen yet')
          :Image.network(_previewImageUrl!, fit: BoxFit.cover, alignment: Alignment.center,)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
            onPressed: (){},
            icon: Icon(Icons.map),
            label: const Text('Select on Map')
            ),
            FlatButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location')
            ),

          ],
        )
      ],
    );
  }
}
