import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'info.dart';
import 'search.dart';

class Booking extends StatefulWidget {
  final name;

  Booking({this.name});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
   bool isBooked = false;
   bool isBooked2 = false;
   bool isBooked3 = false;
   bool isBooked4 = false;
   Color color ;
   bool isSelected = false ;

   String price = 'O Tsh';
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children:[ Container(
              child:ListView(
                padding: EdgeInsets.only(left: 18),
                children: [
                  Padding(
                    padding:EdgeInsets.only(top:40, left:20),
                    child:   Column(
                        children:[
                          SizedBox(height: 24,),
                          Text("Parking Garage",
                            style:TextStyle(fontSize: 34.4,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,),
                          ),
                          SizedBox(height: 6,),
                          Text(widget.name,
                              style:TextStyle(fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.blue[800],)
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 74,),
                     Text('Parking slot',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),

                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                            children:[
                              Card(
                              child: RaisedButton(
                                onPressed: (){
                                   setState(() {
                                     isBooked = true;
                                     
                                   });
                                },
                                //color: isBooked?color:Colors.grey,
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isBooked == false ?Text(
                                      '1 N',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0.1

                                      ),
                                    ):Text('booked'),
                                  ],
                                ),
                              ),
                            ),




                            Card(
                              child: RaisedButton(
                                onPressed: (){
                                   setState(() {
                                     isBooked2 = true;
                                     
                                   });
                                },
                                
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isBooked2 == false ?Text(
                                      '2 N',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0.1

                                      ),
                                    ):Text('booked'),
                                  ],
                                ),
                              ),
                            ),

                              Card(
                              child: RaisedButton(
                                onPressed: (){
                                   setState(() {
                                     isBooked3 = true;
                                     
                                   });
                                },
                                 
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isBooked3 == false ?Text(
                                      '3 N',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0.1

                                      ),
                                    ):Text('booked'),
                                  ],
                                ),
                              ),
                            ),
                              Card(
                              child: RaisedButton(
                                onPressed: (){
                                   setState(() {
                                     isBooked4 = true;
                                      
                                   });
                                },
                                
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isBooked4 == false ?Text(
                                      '4 N',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          letterSpacing: 0.1

                                      ),
                                    ):Text('booked'),
                                  ],
                                ),
                              ),
                            ),
                       ]
                    ),
                  ),
                 SizedBox(height: 74,),
                     Text('Parking time',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  SizedBox(height: 12,),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                       children:[
                           Card(
                              child: RaisedButton(
                                onPressed: (){
                                  setState(() {
                                    isSelected = true;
                                    price = '500 Tsh';
                                  });
                                },
                                child: Padding(padding: EdgeInsets.only(left:12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '1 hours',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: 0.1

                                        ),
                                      ),
                                      SizedBox(height: 6,),
                                      Text(
                                        'Tsh 500',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                              ),
                          ),

                           Card(
                              child: RaisedButton(
                                onPressed: (){
                                  setState(() {
                                    isSelected = true;
                                    price = '1000 Tsh';
                                  });
                                },
                                child: Padding(padding: EdgeInsets.only(left:12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '2 hours',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: 0.1

                                        ),
                                      ),
                                      SizedBox(height: 6,),
                                      Text(
                                        'Tsh 1000',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                              ),
                          ),


                       Card(
                              child: RaisedButton(
                                onPressed: (){
                                  setState(() {
                                    isSelected = true;
                                    price = '1500 Tsh';
                                  });
                                },
                                child: Padding(padding: EdgeInsets.only(left:12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '3 hours',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: 0.1

                                        ),
                                      ),
                                      SizedBox(height: 6,),
                                      Text(
                                        'Tsh 1500',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                              ),
                          ),
                        
                        Card(
                              child: RaisedButton(
                                onPressed: (){
                                  setState(() {
                                    isSelected = true;
                                    price = '2000 Tsh';
                                  });
                                },
                                child: Padding(padding: EdgeInsets.only(left:12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '4 hours',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            letterSpacing: 0.1

                                        ),
                                      ),
                                      SizedBox(height: 6,),
                                      Text(
                                        'Tsh 2000',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),

                                ),
                              ),
                          ),


                       ]
                    ),
                  ),

                  Padding(
                      padding:EdgeInsets.only(top:30, left:40),
                      child:isSelected == false?Text('No price Is selected',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ):Text('$price',
                       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      )
                  ),
                  SizedBox(
                    height: 104,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Pay Via',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                          ),
                          FaIcon(FontAwesomeIcons.stripe,size: 40,)
                        ],
                      )
                  ),
                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:RaisedButton(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          color: Colors.blue,
                          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search1())),
                          child: Text('Pay',
                            style: TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 4,
                                letterSpacing: 0.3),
                          ),)
                    ),
                  ),

                  SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child:RaisedButton(
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          color: Colors.red,
                          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search())),
                          child: Text('Cancel',
                            style: TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 4,
                                letterSpacing: 0.3),
                          ),)
                    ),
                  )
                ],
              ),
            ),

            ]
        )
        )
    );
  }
}