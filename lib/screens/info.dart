

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gmap/screens/payment.dart';
import 'package:gmap/screens/route.dart';
import 'package:gmap/services/geolocator_service.dart';
import 'package:gmap/services/marker_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/place.dart';

class Search1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
                builder: (_, places, __) {
                  var markers = (places != null) ? markerService.getMarkers(places) : List<Marker>();
                  return (places != null)
                      ? Column(
                          children: <Widget>[
                            Container(
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                decoration:BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image:AssetImage('assets/images/park.jpg',)
                    )
                )
            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: places.length,
                                  itemBuilder: (context, index) {
                                    return FutureProvider(
                                      create: (context) =>
                                          geoService.getDistance(
                                              currentPosition.latitude,
                                              currentPosition.longitude,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lat,
                                              places[index]
                                                  .geometry
                                                  .location
                                                  .lng),
                                      child: Container(
                      margin: EdgeInsets.only(left:10, right:10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius:BorderRadius.only(topLeft:Radius.circular(30), topRight:Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:EdgeInsets.only(top:40,left:5),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Parking Name',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                    ),
                                    Text(places[index].name)
                                  ],
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Distance',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)
                                    ),
                                    Text(
                                        ' ${(1000 / 1609).round()} mile')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                          (places[index].rating != null)? Row(
                                                      children: <Widget>[
                                                        RatingBarIndicator(
                                                          rating: places[index]
                                                              .rating,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .amber,size: 30,),
                                                          itemCount: 5,
                                                          itemSize: 10.0,
                                                          direction:
                                                              Axis.horizontal,
                                                        )
                                                      ],
                                                    )
                                                  : Row(),

                              
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text('Parking Price',
                              //         style: TextStyle(
                              //           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                              //     ),
                              //     Text('Tsh 500 shillings')
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(height:40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DataTable(
                                    columns: [
                                      DataColumn(
                                        label:  Text(
                                          'Arrive Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[400],
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label:  Text(
                                          'Departure Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[400],
                                              fontSize: 12
                                          ),
                                        ),
                                      ),
                                    ], rows: <DataRow>[
                                    DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              '10:00 AM',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '11:05 AM',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12
                                              ),
                                            ),
                                          )
                                        ]
                                    )
                                  ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius:BorderRadius.all(Radius.circular(30))
                            ),
                            margin: EdgeInsets.only(top:50),
                            child: RaisedButton(
                                color: Colors.white,
                                onPressed:(){
                                  showDialog(
                                    context:context,
                                    child: AlertDialog(
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Successful', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                          RaisedButton(child: Text('Go to Your Route'), 
                                          color: Colors.blue, onPressed: (){
                                            _launchMapsUrl(
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lat,
                                                  places[index]
                                                      .geometry
                                                      .location
                                                      .lng);
                                          }
                                          //Navigator.of(context).push( MaterialPageRoute(builder: (context)=>MAp()))
                                            )
                                        ],
                                      ),
                                    )
                                );
                                },
                                child:Text('Book Garage')
                            ),
                          ),
                        ],
                      ),
                    )
                                    );
                                  }),
                            )
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

































// import 'package:flutter/material.dart';

// import 'package:gmap/screens/route.dart';

// class Info extends StatefulWidget {
//   @override
//   _InfoState createState() => _InfoState();
// }

// class _InfoState extends State<Info> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//      child: Column(
//           mainAxisAlignment:MainAxisAlignment.start,
//           children:[
//             Container(
//                 height: MediaQuery.of(context).size.height/3,
//                 width: MediaQuery.of(context).size.width,
//                 decoration:BoxDecoration(
//                     image: DecorationImage(
//                         fit: BoxFit.contain,
//                         image:AssetImage('assets/images/park.jpg',)
//                     )
//                 )
//             ),
//             SizedBox(height:10),
//             Expanded(
//                 child:ListView(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left:10, right:10),
//                       height: MediaQuery.of(context).size.height,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent,
//                         borderRadius:BorderRadius.only(topLeft:Radius.circular(30), topRight:Radius.circular(30)),
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding:EdgeInsets.only(top:40,left:5),
//                             child:Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Parking Name',
//                                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
//                                     ),
//                                     Text('New Force Bus Garage')
//                                   ],
//                                 ),

//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Slot Number',
//                                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)
//                                     ),
//                                     Text('25')
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height:40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text('Parking Price',
//                                       style: TextStyle(
//                                         fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//                                   ),
//                                   Text('Tsh 500 shillings')
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height:40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   DataTable(
//                                     columns: [
//                                       DataColumn(
//                                         label:  Text(
//                                           'Arrive Time',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.grey[400],
//                                               fontSize: 12
//                                           ),
//                                         ),
//                                       ),
//                                       DataColumn(
//                                         label:  Text(
//                                           'Departure Time',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.grey[400],
//                                               fontSize: 12
//                                           ),
//                                         ),
//                                       ),
//                                     ], rows: <DataRow>[
//                                     DataRow(
//                                         cells: [
//                                           DataCell(
//                                             Text(
//                                               '10:00 AM',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 12
//                                               ),
//                                             ),
//                                           ),
//                                           DataCell(
//                                             Text(
//                                               '11:05 AM',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   fontSize: 12
//                                               ),
//                                             ),
//                                           )
//                                         ]
//                                     )
//                                   ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           Container(
//                             width: 300,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 borderRadius:BorderRadius.all(Radius.circular(30))
//                             ),
//                             margin: EdgeInsets.only(top:50),
//                             child: RaisedButton(
//                                 color: Colors.white,
//                                 onPressed:_showDialog,
//                                 child:Text('Book Garage')
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 )
//             )
//           ]
//       ),
//     )
//     );
//   }
//   _showDialog(){
//     return showDialog(
//         context:context,
//         child: AlertDialog(
//           content: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Successful', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
//               RaisedButton(child: Text('Go to Your Route'), 
//               color: Colors.blue, onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MAp())))
//             ],
//           ),
//         )
//     );
//   }
// }