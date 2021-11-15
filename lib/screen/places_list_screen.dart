import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:great_places/providers/places_provider.dart';
import 'package:great_places/screen/add_places_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
          )
        ],

      ),
      body:FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).fetchAndSetData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ?  const Center(
            child: CircularProgressIndicator(),
          )
              : Consumer<PlacesProvider>(
              child: const Text('No results yet, please add some.'),
              builder: (context, places, ch) {
                if(places.items.isEmpty){
                  return ch!;
                }else{
                  return ListView.builder(
                      itemCount: places.items.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                  File(places.items[index].image.path)),
                            ),
                            title: Text(places.items[index].title),
                            // TODO open detail page
                          )
                  );
                }
              },
            )
      ),
    );
  }
}
