import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  static const ID = "id";
  static const BRAND = "brand";
  static const PICTURE = "picture";

  String _id;
  String _brand;
  String _picture;

//  getters
  String get brand => _brand;
  String get id => _id;
  String get picture => _picture;

  BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    _brand = snapshot.data()[BRAND];
    _id = snapshot.id;
    _picture = snapshot.data()[PICTURE];
  }
}
