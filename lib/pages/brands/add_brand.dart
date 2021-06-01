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

class AddBrand extends StatefulWidget {
  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  Color grey = Colors.grey;
  var uuid = Uuid();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController id;
  TextEditingController brand;
  TextEditingController image;

  File _image1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    id = new TextEditingController();
    brand = new TextEditingController();
    image = new TextEditingController();
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
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Image.asset(
                        "images/foodtype.png",
                      ),
                    ),
                  ),
                  CustomText(
                    text: "Add Food Type",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5,
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
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: FlatButton(
                        onPressed: () async {
                          print("Printed");

                          Map<String, dynamic> data = {
                            "id": forId,
                            "picture": image.text,
                            "brand": brand.text,
                          };

                          await tablesProvider.addBrandItem(data);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Add",
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
