import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:get/get.dart';

class ProductUploadPage extends StatefulWidget {
  final GlobalKey<ScaffoldState>? globalKey;
  const ProductUploadPage({this.globalKey});
  @override
  _ProductUploadPageState createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  //?? Controllers

  //?? TextEditing Controllers
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productDetailsController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCategoryController =
      TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  List<Asset> _images = <Asset>[];

  void clearAll() {
    _productDetailsController.clear();
    _productPriceController.clear();
    _productNameController.clear();

    _images = [];
  }

  @override
  void dispose() {
    super.dispose();
    clearAll();
  }

  Future<void> uploadPost() async {
    final String docIDn = DateTime.now().millisecondsSinceEpoch.toString();
    final Map<String, dynamic> _docMap = {
      'sellerID': MyGlobals.firebaseCurrentUser.uid,
      'productID': docIDn,
      'outOfStock': false,
      'productDetails': _productDetailsController.text,
      'productName': _productNameController.text.capitalizeFirst,
      'productPrice': _productPriceController.text.trim(),
      'productCategory': _productCategoryController.text,
      'time': Timestamp.now(),
      "images": [''],
    };

    await MyGlobals.productsCollection
        .doc(docIDn)
        .set(_docMap)
        .then((value) => MyWidgets.snackbar(
              title: "Added",
              message: _productNameController.text.trim(),
              bgColor: Colors.green,
            ));

    clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a products',
          style: Styles.headlineText4,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _productNameController,
                        style: Styles.bodyText2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please a product name';
                          } else if (value.length <= 2) {
                            return 'Please enter more than 2 characters';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Product name',
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _productPriceController,
                        style: Styles.bodyText2,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          final numValue = int.tryParse(value!);
                          if (value.isEmpty) {
                            return 'Please a valid price';
                          } else if (numValue! >= 5 && numValue < 100) {
                            return 'Please enter a valid character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _productCategoryController,
                        style: Styles.bodyText2,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Category Code',
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _productDetailsController,
                        maxLines: 15,
                        style: Styles.bodyText2,
                        minLines: 5,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Product Details',
                        ),
                      ),
                      const SizedBox(height: 30),
                      //! Add The new Params
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: MyWidgets.raisedButton(
                  title: 'Upload',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      uploadPost();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
