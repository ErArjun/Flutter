import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greatplaces/helpers/db_helper.dart';
import 'package:greatplaces/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File? image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBhelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image!.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBhelper.getData('user_places');
    _items = datalist
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
