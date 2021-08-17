import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coworking_space/category_wise_detail/features_detail.dart';
// import 'package:coworking_space/google_map/all_place_ingoogle_map_marker.dart';
import 'package:coworking_space/google_map/map_body.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'buy_button_main.dart';
import 'package:coworking_space/book_now_cat/toggle_bar_book.dart';

// ignore: must_be_immutable
class SheetContainer extends StatelessWidget {
  final DocumentSnapshot info;
  SheetContainer({@required this.info});

  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 80;
    // var pos =info['location'].getLocation();
    
    GeoPoint geo=info['location'];
    // ignore: unused_local_variable
    final LatLng latLng=new LatLng(geo.latitude, geo.longitude);      
    // print(latLng);


// print("=======================________________-----------......");
    return DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.65,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.only(top: 25, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Color(0xfff1f1f1)),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ListView(
                      controller: scrollController,
                      children: <Widget>[
                      (info.data.containsKey('spacename'))?Container(
                          // padding: EdgeInsets.all(20),
                          child: Text(
                            "${info['spacename']}".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ):Container(),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (info.data.containsKey('type'))?Text(info['type']):Container(),
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.star_border),
                                  (info.data.containsKey('rating'))?Text(info['rating'].toString()):Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                        (info.data.containsKey('placeofcity'))?Text(
                          info['placeofcity'],
                        ):Container(),

                        SizedBox(
                          height: 10,
                        ),
                        // Spacefacility(amenities: info.amenities, spaceinfo: info.spaceinfo),
                        // offerDetails(sheetItemHeight, info.amenities),
                        (info.data.containsKey('amenities'))?features(sheetItemHeight, info):Container(),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,                         
                            children: [
                              Text("Adress",style: TextStyle(                                
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            ),

                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                child: Text(info['address']),
                              ),
                            ],
                          ) ,
                        ),

                        (info.data.containsKey('amenities'))?Container(
                          padding: EdgeInsets.only(left: 10),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,                         
                            children: [
                              Text("overview",style: TextStyle(                                
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            ),

                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                child: Text(info['overview']),
                              ),
                            ],
                          ) ,
                        ):Container(),

                       
                        SizedBox(height: 20),
                        
                        GoogleLocation(LatLng(geo.latitude, geo.longitude)),
                       
                        SizedBox(height: 20),
                        Center(
                          child: Container(
                            child: Column(
                              children: [
                              (info.data.containsKey('hour_price'))?  Text(
                                  "Hour price : Rs. " + info['hour_price'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ):Text(""),

                                 (info.data.containsKey('day_price'))?  Text(
                                  "Day price : Rs. " + info['day_price'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ):Text(""),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        RentButton(routeName: Booktoggle.routeName,info: info,),
                        SizedBox(height: 50),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

