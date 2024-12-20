import 'dart:ui';

import 'package:airbnb_app/Components/display_total_price.dart';
import 'package:airbnb_app/Components/map_custom_info.dart';
import 'package:airbnb_app/Components/search_bar_and_filter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Components/display_place.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  //Cellection for category
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection("AppCategory");

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //For search bar and filter
            SearchBarAndFilter(),
            //Fetch items from firebase
            listOfCategoryItems(size),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  //for switch button
                  DisplayTotalPrice(),
                  SizedBox(
                    height: 15,
                  ),
                  //for place items
                  DisplayPlace(),
                ],
              ),
            )),
          ],
        ),
      ),
      //For google map
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MapCustomInfo(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> listOfCategoryItems(Size size) {
    return StreamBuilder(
        stream: categoryCollection.snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    top: 80,
                    child: Divider(
                      color: Colors.black12,
                    )),
                SizedBox(
                  height: size.height * 0.12,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: streamSnapshot.data!.docs.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 32,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(
                                  streamSnapshot.data!.docs[index]['image'],
                                  color: selectedIndex == index
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                streamSnapshot.data!.docs[index]['title'],
                                style: TextStyle(
                                  fontSize: 13,
                                  color: selectedIndex == index
                                      ? Colors.black
                                      : Colors.black45,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 3,
                                width: 50,
                                color: selectedIndex == index
                                    ? Colors.black
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
