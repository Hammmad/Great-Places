import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helper/db_helper.dart';
import 'package:great_places/model/place.dart';
import 'package:image_picker/image_picker.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace =
        Place(DateTime.now().millisecond.toString(), title, null, image);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('great_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DbHelper.getData('great_places');
    _items = dataList
        .map((item) =>
            Place(item['id'], item['title'], null, File(item['image'])))
        .toList(growable: true);
    notifyListeners();
  }
}
