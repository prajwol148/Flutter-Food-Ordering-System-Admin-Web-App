import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/pages/products/edit_product.dart';

class ProductsServices {
  String collection = "products";

  Future<List<ProductModel>> getAllProducts() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<bool> deleteProduct(String documentID) async =>
      firebaseFiretore.collection(collection).doc(documentID)
        .delete()
        .then((value) => true)
        .catchError((error) => false);

  Future<bool> updateProduct(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection).doc(data['id'])
          .update(data)
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> addToProducts(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection)
          .add(data)
          .then((value) => true)
          .catchError((error) => false);
}
