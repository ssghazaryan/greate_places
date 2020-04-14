import 'package:GreatPlaces/screens/place_detail_screen.dart';
import 'package:GreatPlaces/screens/place_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/greate_places.dart';
import 'screens/add_place_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatePlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          accentColor: Colors.yellow,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
