import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

LatLng center;

class GoogleLocation extends StatefulWidget {
    GoogleLocation(LatLng latLng){
      center=latLng;
    }
    // final DocumentSnapshot info;
    // final LatLng latLng;
  @override
  _GoogleLocationState createState() => _GoogleLocationState();
}

class _GoogleLocationState extends State<GoogleLocation> {

  // DocumentSnapshot info;
  // _GoogleLocationState(this.center);
  // LatLng info;

  Completer<GoogleMapController> _controller = Completer();
  
// LatLng latLng=new LatLng(geo.latitude, geo.longitude); 
  // LatLng center;

  LatLng _lastMapPosition = center;

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

@override
void initState() { 
   _lastMapPosition = center;
  _onAddMarkerButtonPressed();
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 100, // or use fixed size like 200      
      height: 400,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            gestureRecognizers: < Factory<OneSequenceGestureRecognizer> >[
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer()
                  )
                  ].toSet(),
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onMapTypeButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.map, size: 36.0),
                    heroTag: 'tag1',
                  ),
                  SizedBox(height: 16.0),
                  // FloatingActionButton(
                  //   onPressed: _onAddMarkerButtonPressed,
                  //   materialTapTargetSize: MaterialTapTargetSize.padded,
                  //   backgroundColor: Colors.green,
                  //   child: const Icon(Icons.add_location, size: 36.0),
                  //   heroTag: 'tag2',
                  // ),
                  // SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      MapUtils.openMap(center.latitude, center.longitude);
                      // launchMap();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.location_on, size: 36.0),
                    heroTag: 'tag3',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
