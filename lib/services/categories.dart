import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/models/categories.dart';

class CategoriesServices {
  String collection = "categories";

  Future<List<CategoryModel>> getAllCategories() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<CategoryModel> categories = [];
        for (DocumentSnapshot category in result.docs) {
          categories.add(CategoryModel.fromSnapshot(category));
        }
        return categories;
      });

  Future<bool> deleteCategories(String documentID) async =>
      firebaseFiretore.collection(collection).doc(documentID)
          .delete()
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> updateCategories(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection).doc(data['id'])
          .update(data)
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> addToCategories(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection)
          .add(data)
          .then((value) => true)
          .catchError((error) => false);

}
