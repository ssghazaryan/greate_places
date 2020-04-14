import 'package:GreatPlaces/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/greate_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatePlaces>(context, listen: false).findByID(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => MapsScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
