import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class CartController extends GetxController {
  CollectionReference _collectionRef(String category) =>
      FirebaseFirestore.instance
          .collection('$category-Cart')
          .doc(MyGlobals.firebaseCurrentUser.uid)
          .collection('cart');

  Future<Product> getProduct(String productID) => FirebaseFirestore.instance
          .collection('Products')
          .doc(productID)
          .get()
          .then((value) {
        // ignore: cast_nullable_to_non_nullable
        return Product.fromMap(value.data() as Map<String, dynamic>);
      });


  Query getCartList(String category) => FirebaseFirestore.instance
      .collection('$category-Cart')
      .doc(MyGlobals.firebaseCurrentUser.uid)
      .collection('cart');

  Future<void> deleteCartItem(
    String productID,
    int quantity,
    String category,
  ) async =>
      _collectionRef(category).doc(productID).delete();

  Future<void> addCartItem(
    String productID,
    int price,
    String category,
  ) async =>
      _collectionRef(category).doc(productID).set({
        "quantity": 1,
        "productID": productID,
        "isSelected": false,
        "productPrice": price,
      }).then((value) => MyWidgets.toast("Added"));

  Future<void> incrementCartItem(
    String productID,
    int quantity,
    int totalPrice,
    String category,
  ) async =>
      _collectionRef(category)
          .doc(productID)
          .update({"quantity": quantity + 1});

  Future<void> updateIsSelected({
    required String productID,
    required bool isSelected,
    required String category,
  }) async =>
      _collectionRef(category)
          .doc(productID)
          .update({"isSelected": isSelected});

  Future<void> decrementCartItem(
    String productID,
    int quantity,
    int totalPrice,
    String category,
  ) async {
    if (quantity >= 2) {
      _collectionRef(category)
          .doc(productID)
          .update({"quantity": quantity - 1});
    }
  }
}
