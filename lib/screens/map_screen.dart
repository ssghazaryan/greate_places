import 'package:GreatPlaces/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  //static const routeName = '/map-screen';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapsScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 55.763081,
        longitude: 37.619760,
      ),
      this.isSelecting = false});
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.pop(context, _pickedLocation);
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 10,
        ),
        onLongPress: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null && widget.isSelecting
            ? null
            : {
                Marker(markerId: MarkerId('m1'), position: _pickedLocation?? LatLng( widget.initialLocation.latitude, widget.initialLocation.longitude)),
              },
      ),
    );
  }
}
