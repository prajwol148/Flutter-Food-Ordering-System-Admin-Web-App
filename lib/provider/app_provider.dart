import 'package:ecommerce_admin_tut/helpers/enumerators.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  DisplayedPage currentPage;
  OrderServices _orderServices = OrderServices();
  OrderModel _orderModel;
  double revenue = 0;
  int month = 0;
  double januaryRevenue = 0;
  double februaryRevenue = 0;
  double marchRevenue = 0;
  double aprilRevenue = 0;
  double mayRevenue = 0;
  double juneRevenue = 0;
  double julyRevenue = 0;
  double augustRevenue = 0;
  double septemberRevenue = 0;
  double octoberRevenue = 0;
  double novemberRevenue = 0;
  double decemberRevenue = 0;

  AppProvider.init() {
    _getRevenue();
    changeCurrentPage(DisplayedPage.HOME);
  }

  changeCurrentPage(DisplayedPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  void _getRevenue() async {
    await _orderServices.getAllOrders().then((orders) {
      for (OrderModel order in orders) {
        month = DateTime.fromMillisecondsSinceEpoch(order.createdAt).month;
        switch (month) {
          case 1:
            januaryRevenue += order.total;
            break;
          case 2:
            februaryRevenue += order.total;
            break;
          case 3:
            marchRevenue += order.total;
            break;
          case 4:
            aprilRevenue += order.total;
            break;
          case 5:
            mayRevenue += order.total;
            break;
          case 6:
            juneRevenue += order.total;
            break;
          case 7:
            julyRevenue += order.total;
            break;
          case 8:
            augustRevenue += order.total;
            break;
          case 9:
            septemberRevenue += order.total;
            break;
          case 10:
            octoberRevenue += order.total;
            break;
          case 11:
            novemberRevenue += order.total;
            break;
          case 12:
            decemberRevenue += order.total;
            break;
        }
        revenue = revenue + order.total;
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
        print("======= TOTAL REVENUE: ${revenue.toString()}");
      }
      notifyListeners();
    });
  }
}
