import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bioplus/core/db.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/models/price.dart';
import 'package:bioplus/view/market/product_category_models.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  Rx<List<ProductCategoryModel>>? _productCategoryModelList;
  Rx<List<Price>>? _productPriceList;

  RxBool showProduct = false.obs;

  // bool toggleTile({bool show}) {
  //   show.value = !show.value;
  //   return show;
  // }

  Rx<List<ProductCategoryModel>> get productCategoryModelList =>
      _productCategoryModelList!;
  Rx<List<Price>> get productPriceList => _productPriceList!;
  @override
  void onInit() {
    _productModelList.bindStream(_productStream());
    _productCategoryModelList = Rx<List<ProductCategoryModel>>([]);
    _productPriceList = Rx<List<Price>>([]);
    _productCategoryModelList!.bindStream(_productCategoryStream());
    _productPriceList!.bindStream(_productListStream());
    super.onInit();
  }

  Stream<List<ProductCategoryModel>> _productCategoryStream() {
    return FirebaseFirestore.instance
        .collection('ProductCategory')
        .orderBy('title')
        .snapshots()
        .map((QuerySnapshot query) {
      final List<ProductCategoryModel> retVal = [];
      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(ProductCategoryModel.fromMap(element.data() as Map<String , dynamic>));
      });
      return retVal;
    });
  }

  Stream<List<Price>> _productListStream() {
    return FirebaseFirestore.instance
        .collection('pricing')
        .doc('product')
        .collection('pricing')
        .snapshots()
        .map((QuerySnapshot query) {
      final List<Price> retVal = [];
      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(Price.fromMap(element.data() as Map<String , dynamic>));
      });
      return retVal;
    });
  }

  Rx<List<Product>> get productModelList => _productModelList;
  final Rx<List<Product>> _productModelList = Rx<List<Product>>([]);
  Stream<List<Product>> _productStream() {
    return MyGlobals.productsCollection
        .orderBy('productName')
        .snapshots()
        .map((QuerySnapshot query) {
      final List<Product> retVal = [];
      // ignore: avoid_function_literals_in_foreach_calls
      query.docs.forEach((element) {
        retVal.add(Product.fromMap(element.data() as Map<String , dynamic>));
      });
      return retVal;
    });
  }
}
