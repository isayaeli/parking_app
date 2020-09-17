import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmap/models/place.dart';
import 'package:gmap/screens/search.dart';
import 'package:gmap/services/geolocator_service.dart';
import 'package:gmap/services/places_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration = createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(configuration, 'assets/images/parking-icon.png');
        }),
        ProxyProvider2<Position,BitmapDescriptor,Future<List<Place>>>( 
          update: (context,position,icon,places){
            return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude,icon) :null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool userIn = false;
  bool isLoaging = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _handleSignIn() async {
  GoogleSignInAccount googleUser = await googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  FirebaseUser user = authResult.user;
  print("signed in " + user.displayName);

  setState(() {
    userIn = true;
  
  });

 setState(() {
   isLoaging =true;
 });

  return user;

}


 void _signOut(){
   googleSignIn.signOut();
   print('user sign out');
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:Stack(
            children: [
              Container(
                decoration:BoxDecoration(
                    image:DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/login.jpg')
                    )
                ),
              ),
              Container(
                child: ListView(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 150, right: 30, left: 50),
                      child: Container(
                        height: 100,
                        child:Column(
                            children:<Widget>[
                              Padding(padding: EdgeInsets.only(left: 1),
                                child: Text('Dar es Salaam',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                  ) ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 1),
                                child: Text('Automobile',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                  ) ,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 1),
                                child: Text('The best way that points you to exactly location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                  ) ,
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20, right: 30, left: 65),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:BorderRadius.all(Radius.circular(30))
                          ),
                          height: 70,
                          margin: EdgeInsets.only(left: 20, right:20, top: 30),
                          child: FlatButton(onPressed:()=>_handleSignIn().whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search()))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:<Widget>[
                                  Text('Login',
                                    style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  FaIcon(FontAwesomeIcons.google)
                                ]
                            ),
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}
