import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/brands.dart';

class BrandsServices {
  String collection = "brands";

  Future<List<BrandModel>> getAllBrands() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<BrandModel> brands = [];
        for (DocumentSnapshot brand in result.docs) {
          brands.add(BrandModel.fromSnapshot(brand));
        }
        return brands;
      });

  Future<bool> deleteBrands(String documentID) async =>
      firebaseFiretore.collection(collection).doc(documentID)
          .delete()
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> updateBrand(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection).doc(data['id'])
          .update(data)
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> addToBrands(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection)
          .add(data)
          .then((value) => true)
          .catchError((error) => false);

}
