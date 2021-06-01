import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_tut/provider/tables.dart';
import 'package:ecommerce_admin_tut/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProduct extends StatefulWidget {
  final Map<String, dynamic> product;
  EditProduct({this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  Color grey = Colors.grey;
  var uuid = Uuid();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController id;
  TextEditingController name;
  TextEditingController price;
  TextEditingController quantity;
  TextEditingController image;
  TextEditingController description;
  TextEditingController brand;
  List<String> selectedSizes = [];
  List<String> selectedColors = [];
  TextEditingController category;
  bool onSale = false;
  bool featured = false;
  Color white = Colors.white;
  Color black = Colors.black;
  Color red = Colors.red;
  List<String> colors = <String>[];
  File _image1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    id = new TextEditingController(text: widget.product['id']);
    name = new TextEditingController(text: widget.product['name']);
    price = new TextEditingController(text: widget.product['price'].toString());
    quantity =
        new TextEditingController(text: widget.product['quantity'].toString());
    //selectedColors = widget.product['colors'];
    //selectedSizes = widget.product['sizes'];
    image = new TextEditingController(text: widget.product['image']);
    description =
        new TextEditingController(text: widget.product['description']);
    brand = new TextEditingController(text: widget.product['brand']);
    category = new TextEditingController(text: widget.product['category']);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TablesProvider tablesProvider = Provider.of<TablesProvider>(context);
    String forId = uuid.v4();
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 24)
                  ]),
              height: 800,
              width: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  CustomText(
                    text: "Edit Product",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Name'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: brand,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Food Type'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: category,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Category'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: description,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Description'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: quantity,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Quantity'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: price,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Price'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: image,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'ImageUrl'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Delivery Time'),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: selectedSizes.contains('5 Mins'),
                          onChanged: (value) => changeSize('5 Mins')),
                      Text('5 Mins'),
                      Checkbox(
                          value: selectedSizes.contains('10 Mins'),
                          onChanged: (value) => changeSize('10 Mins')),
                      Text('10 Mins'),
                      Checkbox(
                          value: selectedSizes.contains('15 Mins'),
                          onChanged: (value) => changeSize('15 Mins')),
                      Text('15 Mins'),
                    ],
                  ),
                  Text('Available Addings'),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: selectedColors.contains('Mayonise'),
                          onChanged: (value) =>
                              changeSelectedColor('Mayonise')),
                      Text('Mayonise'),
                      Checkbox(
                          value: selectedColors.contains('Ketchup'),
                          onChanged: (value) => changeSelectedColor('Ketchup')),
                      Text('Ketchup'),
                      Checkbox(
                          value: selectedColors.contains('Aachar'),
                          onChanged: (value) => changeSelectedColor('Aachar')),
                      Text('Aachar'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Sale'),
                          SizedBox(
                            width: 5,
                          ),
                          Switch(
                              value: onSale,
                              onChanged: (value) {
                                setState(() {
                                  onSale = value;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Featured'),
                          SizedBox(
                            width: 10,
                          ),
                          Switch(
                              value: featured,
                              onChanged: (value) {
                                setState(() {
                                  featured = value;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: FlatButton(
                        onPressed: () async {
                          print("Printed");

                          Map<String, dynamic> data = {
                            "id": id.text,
                            "name": name.text,
                            "price": double.parse(price.text),
                            "description": description.text,
                            "picture": image.text,
                            "quantity": int.parse(quantity.text),
                            "brand": brand.text,
                            "category": category.text,
                            "sizes": selectedSizes,
                            'sale': onSale,
                            "colors": selectedColors,
                            'featured': featured
                          };

                          await tablesProvider.updateProductItem(data);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Edit",
                                size: 22,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeSelectedColor(String color) {
    if (selectedColors.contains(color)) {
      setState(() {
        selectedColors.remove(color);
      });
    } else {
      setState(() {
        selectedColors.insert(0, color);
      });
    }
  }

  void changeSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  Future getImage() async {
    // Get image from gallery.
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImageToFirebase(image);
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      final Reference storageReference =
          FirebaseStorage().ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      _addPathToDatabase(imageLocation);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child(text);
      var imageString = await ref.getDownloadURL();

      // Add location and url to database
      await Firestore.instance
          .collection('products')
          .document()
          .setData({'url': imageString, 'location': text});
    } catch (e) {
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          });
    }
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  // void validateAndUpload() async {
  //   String imageUrl1;
  //   String forId = uuid.v4();

  //   final FirebaseStorage storage = FirebaseStorage.instance;
  //   final String picture1 =
  //       "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
  //   UploadTask task1 = storage.ref().child(picture1).putFile(_image1);

  //   TaskSnapshot snapshot1 = await task1.then((snapshot) => snapshot);

  //   task1.then((snapshot3) async {
  //     imageUrl1 = await snapshot1.ref.getDownloadURL();

  //     Map<String, dynamic> data = {
  //       "id": forId,
  //       "picture": imageUrl1,
  //       "name": name.text,
  //       "price": double.parse(price.text),
  //       "quantity": int.parse(quantity.text),
  //       "description": description.text,
  //       "brand": brand.text,
  //       "category": category.text,
  //       "sizes": selectedSizes,
  //       'sale': onSale,
  //       "colors": selectedColors,
  //       'featured': featured
  //     };
  //     Firestore.instance.collection("products").add(data);
  //   });
  // }
}
