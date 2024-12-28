import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  void toggleFavorite(DocumentSnapshot place) async {
    String placeId = place.id;
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
      await _removeFavorite(placeId); // remove grom favorite
    } else {
      _favoriteIds.add(placeId);
      await _addFavorites(placeId); // add to favorite
    }
    notifyListeners();
  }


  //check if the place is in favorite list
   bool isExist(DocumentSnapshot place) {
    return _favoriteIds.contains(place.id);
  }

  // add favorite items to firestore
  Future<void> _addFavorites(String placeId) async {
    try {
      // create the userFavorite collection and add items as favorites in firestore
      await firebaseFirestore
          .collection("userFavorites")
          .doc(placeId)
          .set({'isFavorite': true});
    } catch (e) {
      print(e.toString());
    }
  }

  // remove favorite items from firestore
  Future<void> _removeFavorite(String placeId) async {
    try {
      // create the userFavorite collection and add items as favorites in firestore
      await firebaseFirestore.collection("userFavorites").doc(placeId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //load favorite items from firestore(if user make some items favorite and load this items)
  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot = await firebaseFirestore.collection("userFavorites").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //Static method to access provider in any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);

  }
}
