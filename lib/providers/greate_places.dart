import 'dart:io';
import 'package:GreatPlaces/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findByID(String id){
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(
    String title,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAdress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: title,
        location: updatedLocation);

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': pickedLocation.latitude,
      'loc_lng': pickedLocation.longitude,
      'address': address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
