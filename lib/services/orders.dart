import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/helpers/costants.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';

class OrderServices {
  String collection = "orders";

  Future<List<OrderModel>> getAllOrders() async =>
      firebaseFiretore.collection(collection).get().then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

  Future<bool> deleteOrders(String documentID) async =>
      firebaseFiretore.collection(collection).doc(documentID)
          .delete()
          .then((value) => true)
          .catchError((error) => false);

  Future<bool> updateOrder(Map<String, dynamic> data) async =>
      firebaseFiretore.collection(collection).doc(data['id'])
          .update(data)
          .then((value) => true)
          .catchError((error) => false);
}
