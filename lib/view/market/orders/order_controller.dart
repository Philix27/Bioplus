import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/view/market/orders/ordered_product_m.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class OrderController extends GetxController {
  static String userID = MyGlobals.firebaseCurrentUser.uid;
  static final Timestamp currentTime = Timestamp.now();
  Query getCartList() {
    final Query _v = FirebaseFirestore.instance
        .collection('Shop-Orders')
        .where("userID", isEqualTo: userID);

    return _v;
  }

  Query allOrders() => FirebaseFirestore.instance.collection('Shop-Orders');

  Future<void> updateCompleted(
    bool isCompleted,
    String docID,
  ) =>
      FirebaseFirestore.instance.collection('Shop-Orders').doc(docID).update({
        "isCompleted": !isCompleted,
        "completedBy": userID,
        "timeCompleted": currentTime,
      });

  Future<void> updateVerifyPayment(
    bool paymentVerified,
    String docID,
  ) =>
      FirebaseFirestore.instance.collection('Shop-Orders').doc(docID).update({
        "paymentVerified": !paymentVerified,
        "paymentVerifiedBy": userID,
        "paymentVerificationTime": currentTime,
      });

  // ignore: avoid_positional_boolean_parameters
  Future<void> updateDelivered(bool isDelivered, String docID) =>
      FirebaseFirestore.instance.collection('Shop-Orders').doc(docID).update({
        "isDelivered": !isDelivered,
        "deliveredBy": userID,
        "deliveryTime": currentTime,
      });

  Future<void> updateDeliveredProduct(
          bool isDelivered, String docID, String productID) =>
      FirebaseFirestore.instance
          .collection('Shop-Orders')
          .doc(docID)
          .collection("products")
          .doc(productID)
          .update({
        "isDelivered": !isDelivered,
        "deliveredBy": userID,
        "deliveryTime": currentTime,
      });

  Future<void> addAnOrder({
    int? totalAmount,
    List<String>? productIDList,
    required String phoneNumber,
    required String address,
    required List<OrderedProduct> oProd,
    required String displayCode,
  }) async {
    final String docID = currentTime.millisecondsSinceEpoch.toString();

    final Map<String, dynamic> orderMap = {
      "userID": userID,
      "productIDList": productIDList,
      "totalAmount": totalAmount,
      "isCompleted": false,
      "isDelivered": false,
      "paymentVerified": false,
      "dateOrdered": currentTime,
      "docID": docID,
      "orderID": docID,
      "phoneNumber": phoneNumber,
      "address": address,
      "category": displayCode,
    };

    await FirebaseFirestore.instance
        .collection('Shop-Orders')
        .doc(docID)
        .set(orderMap)
        .then((value) => MyWidgets.toast("Order placed"));

    oProd.forEach((v) {
      final Map<String, dynamic> orderedProductMap = {
        "id": v.id,
        "quantity": v.quantity,
        "price": v.price,
        "totalPrice": v.totalPrice,
        "isDelivered": v.isDelivered,
      };

      FirebaseFirestore.instance
          .collection('Shop-Orders')
          .doc(docID)
          .collection("products")
          .doc(v.id)
          .set(orderedProductMap)
          .then((value) => MyWidgets.toast("Order placed"));
    });
  }
}
