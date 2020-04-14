import 'package:GreatPlaces/providers/greate_places.dart';
import 'package:GreatPlaces/screens/add_place_screen.dart';
import 'package:GreatPlaces/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatePlaces>(
                    child: Center(
                      child:
                          const Text('Got no places yet, start adding some!'),
                    ),
                    builder: (ctx, greatPlaces, Widget ch) =>
                        greatPlaces.items.length <= 0
                            ? ch
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title),
                                  subtitle: Text(greatPlaces.items[i].location.address),
                                  onTap: () {
                                    Navigator.pushNamed(context, PlaceDetailScreen.routeName, arguments: greatPlaces.items[i].id);
                                  },
                                ),
                              ),
                  ),
      ),
    );
  }
}
