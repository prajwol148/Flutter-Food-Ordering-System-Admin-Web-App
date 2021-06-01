import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const PICTURE = "picture";
  static const CATEGORY = "category";

  String _id;
  String _category;
  String _picture;

//  getters
  String get category => _category;
  String get picture => _picture;
  String get id => _id;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _category = snapshot.data()[CATEGORY];
    _picture = snapshot.data()[PICTURE];
    _id = snapshot.id;
  }
}
