import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context, listen: false);
    tablesProvider.isCategorySelected = false;
    tablesProvider.isBrandSelected = false;
    tablesProvider.isUserSelected = false;
    tablesProvider.isProductSelected = false;
    tablesProvider.isOrderSelected = false;
    tablesProvider.selecteds.clear();
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> globalNavigateTo(String routeName, BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }


  void goBack() {
    return navigatorKey.currentState.pop();
  }


}