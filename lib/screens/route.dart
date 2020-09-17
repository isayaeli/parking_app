import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MAp extends StatefulWidget {
  @override
  _MApState createState() => _MApState();
}

class _MApState extends State<MAp> {


  GoogleMapController mapController;

  final LatLng _center = const LatLng(-6.802353, 39.279556);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
            height:MediaQuery.of(context).size.height,
            child:GoogleMap(
                mapType: MapType.hybrid,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(target: _center, zoom:14.0)
            )
        ),
      )
    );
  }
}