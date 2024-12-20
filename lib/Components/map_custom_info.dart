import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCustomInfo extends StatefulWidget {
  const MapCustomInfo({super.key});

  @override
  State<MapCustomInfo> createState() => _MapCustomInfoState();
}

class _MapCustomInfoState extends State<MapCustomInfo> {
  LatLng myCurrentLocation = LatLng(20.5937, 78.9629);
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController googleMapController;
  List<Marker> markers = [];
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  //firebase collection to load latlang of place
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("myAppCollection");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadmarker();
  }

  //For Custom marker
  Future<void> _loadmarker() async {
    Size size = MediaQuery.of(context).size;
    customIcon = await BitmapDescriptor.asset(
        ImageConfiguration(), "assets/images/marker.png",
        height: 40, width: 30);

    placeCollection.snapshots().listen((QuerySnapshot streamSnapshot) {
      if (streamSnapshot.docs.isNotEmpty) {
        final List allMarkers = streamSnapshot.docs;
        List<Marker> myMarkers = [];
        for (final marker in allMarkers) {
          final dat = marker.data();
          final data = (dat) as Map;
          myMarkers.add(
            Marker(
              markerId: MarkerId(
                data['address'],
              ),
              position: LatLng(data['latitude'], data['longitude']),
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: size.height * 0.32,
                    width: size.width * 0.8,
                  ),
                  LatLng(data['latitude'], data['longitude']),
                );
              },
              icon: customIcon,
            ),
          );
        }
        setState(() {
          markers = myMarkers;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {
        showModalBottomSheet(
          clipBehavior: Clip.none,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: Colors.white,
              height: size.height * 0.77,
              width: size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.77,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: myCurrentLocation,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        googleMapController = controller;
                        _customInfoWindowController.googleMapController =
                            controller;
                      },
                      onTap: (argument) {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      markers: markers.toSet(),
                    ),
                  ),
                  CustomInfoWindow(
                    controller: _customInfoWindowController,
                    height: size.height * 0.34,
                    width: size.width * 0.85,
                    offset: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 170, vertical: 5),
                      child: Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      label: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Text(
              "Map",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.map_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
