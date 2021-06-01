import 'dart:math';

import 'package:ecommerce_admin_tut/models/brands.dart';
import 'package:ecommerce_admin_tut/models/categories.dart';
import 'package:ecommerce_admin_tut/models/orders.dart';
import 'package:ecommerce_admin_tut/models/products.dart';
import 'package:ecommerce_admin_tut/models/user.dart';
import 'package:ecommerce_admin_tut/services/brands.dart';
import 'package:ecommerce_admin_tut/services/categories.dart';
import 'package:ecommerce_admin_tut/services/orders.dart';
import 'package:ecommerce_admin_tut/services/products.dart';
import 'package:ecommerce_admin_tut/services/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_table/DatatableHeader.dart';

class TablesProvider with ChangeNotifier {
  // ANCHOR table headers
  List<DatatableHeader> usersTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Email",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> ordersTableHeader = [
    DatatableHeader(
        text: "User Id",
        value: "userId",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Order Status",
        value: "status",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Description",
        value: "description",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Created At",
        value: "createdAt",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Total",
        value: "total",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> productsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: false,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Name",
        value: "name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Brand",
        value: "brand",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category",
        value: "category",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Quantity",
        value: "quantity",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sizes",
        value: "sizes",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Colors",
        value: "colors",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Featured",
        value: "featured",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Sale",
        value: "sale",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Price",
        value: "price",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> brandsTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Brand Name",
        value: "brand",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  List<DatatableHeader> categoriesTableHeader = [
    DatatableHeader(
        text: "ID",
        value: "id",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Category Name",
        value: "category",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.left),
  ];
  List<int> perPages = [5, 10, 15, 100];
  int total = 100;
  int currentPerPage;
  int currentPage = 1;
  String currentOrderStatus = '';
  bool isSearch = false;
  bool isProductSelected = false;
  bool isCategorySelected = false;
  bool isOrderSelected = false;
  bool isUserSelected = false;
  bool isBrandSelected = false;
  List<Map<String, dynamic>> usersTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> ordersTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> productsTableSource = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> categoriesTableSource =
      List<Map<String, dynamic>>();
  List<Map<String, dynamic>> brandsTableSource = List<Map<String, dynamic>>();

  List<Map<String, dynamic>> selecteds = List<Map<String, dynamic>>();
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;

  UserServices _userServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get users => _users;

  OrderServices _orderServices = OrderServices();
  List<OrderModel> _orders = <OrderModel>[];
  List<OrderModel> get orders => _orders;

  ProductsServices _productsServices = ProductsServices();
  List<ProductModel> _products = <ProductModel>[];
  List<ProductModel> get products => _products;

  BrandsServices _brandsServices = BrandsServices();
  List<BrandModel> _brands = <BrandModel>[];

  CategoriesServices _categoriesServices = CategoriesServices();
  List<CategoryModel> _categories = <CategoryModel>[];

  Future _loadFromFirebase() async {
    _users = await _userServices.getAllUsers();
    _orders = await _orderServices.getAllOrders();
    _products = await _productsServices.getAllProducts();
    _brands = await _brandsServices.getAllBrands();
    _categories = await _categoriesServices.getAllCategories();
  }

  List<Map<String, dynamic>> _getUsersData() {
    isLoading = true;
    notifyListeners();
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    var i = _users.length;
    print(i);
    for (UserModel userData in _users) {
      temps.add({
        "id": userData.id,
        "email": userData.email,
        "name": userData.name,
      });
      i++;
    }
    isLoading = false;
    notifyListeners();
    return temps;
  }

  List<Map<String, dynamic>> _getBrandsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (BrandModel brand in _brands) {
      temps.add(
          {"id": brand.id, "brand": brand.brand, "picture": brand.picture});
    }
    return temps;
  }

  List<Map<String, dynamic>> _getCategoriesData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (CategoryModel category in _categories) {
      temps.add({
        "id": category.id,
        "category": category.category,
        "picture": category.picture
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getOrdersData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (OrderModel order in _orders) {
      temps.add({
        "id": order.id,
        "userId": order.userId,
        "description": order.description,
        "createdAt": DateFormat.yMMMd()
            .format(DateTime.fromMillisecondsSinceEpoch(order.createdAt)),
        "total": "Npr. " + "${order.total}",
        "status": order.status
      });
    }
    return temps;
  }

  List<Map<String, dynamic>> _getProductsData() {
    List<Map<String, dynamic>> temps = List<Map<String, dynamic>>();
    for (ProductModel product in _products) {
      temps.add({
        "id": product.id,
        "name": product.name,
        "brand": product.brand,
        "category": product.category,
        "quantity": product.quantity,
        "sale": product.sale,
        "featured": product.featured,
        "colors": product.colors,
        "sizes": product.sizes,
        "price": product.price,
        "description": product.description,
        "picture": product.picture
      });
    }
    return temps;
  }

  deleteProductItems() async {
    bool isSuccess = false;
    for (Map<String, dynamic> item in selecteds) {
      isSuccess = await _productsServices.deleteProduct(item['id']);
      if (isSuccess)
        productsTableSource
            .removeWhere((element) => element['id'] == item['id']);
    }
    if (isSuccess) {
      print('Deleted Successfully');
      isProductSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  deleteBrandItems() async {
    bool isSuccess = false;
    for (Map<String, dynamic> item in selecteds) {
      isSuccess = await _brandsServices.deleteBrands(item['id']);
      if (isSuccess)
        brandsTableSource.removeWhere((element) => element['id'] == item['id']);
    }
    if (isSuccess) {
      print('Deleted Successfully');
      isBrandSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  deleteCategoryItems() async {
    bool isSuccess = false;
    for (Map<String, dynamic> item in selecteds) {
      isSuccess =
          await _categoriesServices.deleteCategories(item['id'].toString());
      if (isSuccess)
        categoriesTableSource
            .removeWhere((element) => element['id'] == item['id']);
    }
    if (isSuccess) {
      print('Deleted Successfully');
      isCategorySelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  deleteUserItems() async {
    bool isSuccess = false;
    for (Map<String, dynamic> item in selecteds) {
      isSuccess = await _userServices.deleteUser(item['id']);
      if (isSuccess)
        usersTableSource.removeWhere((element) => element['id'] == item['id']);
    }
    if (isSuccess) {
      print('Deleted Successfully');
      isUserSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  deleteOrderItems() async {
    bool isSuccess = false;
    for (Map<String, dynamic> item in selecteds) {
      isSuccess = await _orderServices.deleteOrders(item['id']);
      if (isSuccess)
        ordersTableSource.removeWhere((element) => element['id'] == item['id']);
    }
    if (isSuccess) {
      print('Deleted Successfully');
      isOrderSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  updateBrandItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _brandsServices.updateBrand(data);
    if (isSuccess) {
      brandsTableSource[brandsTableSource
          .indexWhere((element) => element['id'] == data['id'])] = data;
      print('Updated Successfully');
      isBrandSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  updateCategoryItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _categoriesServices.updateCategories(data);

    if (isSuccess) {
      categoriesTableSource[categoriesTableSource
          .indexWhere((element) => element['id'] == data['id'])] = data;
      print('Updated Successfully');
      isCategorySelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  updateProductItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _productsServices.updateProduct(data);

    if (isSuccess) {
      productsTableSource[productsTableSource
          .indexWhere((element) => element['id'] == data['id'])] = data;
      print('Updated Successfully');
      isProductSelected = false;
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  _initData() async {
    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    usersTableSource.addAll(_getUsersData());
    ordersTableSource.addAll(_getOrdersData());
    productsTableSource.addAll(_getProductsData());
    brandsTableSource.addAll(_getBrandsData());
    categoriesTableSource.addAll(_getCategoriesData());

    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value) {
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      usersTableSource
          .sort((a, b) => b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      usersTableSource
          .sort((a, b) => a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    notifyListeners();
  }

  onProductSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      isProductSelected = true;
      selecteds.add(item);
    } else {
      isProductSelected = false;
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onUserSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      isUserSelected = true;
      selecteds.add(item);
    } else {
      isUserSelected = false;
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onOrderSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      //to clear previous selection
      selecteds.clear();
      currentOrderStatus = item['status'];
      isOrderSelected = true;
      selecteds.add(item);
    } else {
      isOrderSelected = false;
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onBrandSelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      isBrandSelected = true;
      selecteds.add(item);
    } else {
      isBrandSelected = false;
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onCategorySelected(bool value, Map<String, dynamic> item) {
    print("$value  $item ");
    if (value) {
      isCategorySelected = true;
      selecteds.add(item);
    } else {
      isCategorySelected = false;
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value) {
    if (value) {
      selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value) {
    currentPerPage = value;
    notifyListeners();
  }

  previous() {
    currentPage = currentPage >= 2 ? currentPage - 1 : 1;
    notifyListeners();
  }

  next() {
    currentPage++;
    notifyListeners();
  }

  TablesProvider.init() {
    _initData();
  }

  addBrandItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _brandsServices.addToBrands(data);

    if (isSuccess) {
      brandsTableSource.add(data);
      print('Added Successfully');
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  addCategoryItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _categoriesServices.addToCategories(data);

    if (isSuccess) {
      categoriesTableSource.add(data);
      print('Added Successfully');
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }

  addProductItem(Map<String, dynamic> data) async {
    bool isSuccess = false;
    isSuccess = await _productsServices.addToProducts(data);

    if (isSuccess) {
      productsTableSource.add(data);
      print('Added Successfully');
    } else
      print('Operation Unsuccessful');

    notifyListeners();
  }
}
