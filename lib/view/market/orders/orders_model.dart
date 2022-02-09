import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart';

class OrdersM {
  static const String USER_ID = "userID";
  static const String PRODUCT_ID_LIST = "productIDList";
  static const String TOTAL_AMOUNT = "totalAmount";
  static const String IS_COMPLETED = "isCompleted";
  static const String IS_DELIVERED = "isDelivered";
  static const String PAYMENT_VERIFIED = "paymentVerified";
  static const String DOC_ID = "docID";
  static const String ORDER_ID = "orderID";
  static const String PHONE_NUMBER = "phoneNumber";
  static const String ADDRESS = "address";
  static const String DATE_ORDERED = "dateOrdered";

  final String? userID;
  final List<String>? productIDList;
  final int? totalAmount;
  final bool? isCompleted;
  final bool? isDelivered;
  final bool? paymentVerified;
  final String? docID;
  final String? orderID;
  final String? phoneNumber;
  final String? address;
  final String? dateOrdered;
  final Timestamp? timestamp;

  OrdersM({
    this.userID,
    this.productIDList,
    this.totalAmount,
    this.isCompleted,
    this.isDelivered,
    this.paymentVerified,
    this.docID,
    this.orderID,
    this.phoneNumber,
    this.address,
    this.timestamp,
    this.dateOrdered,
  });

  Map<String, dynamic> toMap() {
    return {
      USER_ID: userID,
      PRODUCT_ID_LIST: productIDList,
      TOTAL_AMOUNT: totalAmount,
      IS_COMPLETED: isCompleted,
      IS_DELIVERED: isDelivered,
      PAYMENT_VERIFIED: paymentVerified,
      DOC_ID: docID,
      ORDER_ID: orderID,
      PHONE_NUMBER: phoneNumber,
      ADDRESS: address,
    };
  }

  factory OrdersM.fromMap(Map<String, dynamic> map) {
    final Timestamp tempTime = map[DATE_ORDERED] as Timestamp;
    final String time = format(tempTime.toDate()).toString();
    return OrdersM(
      dateOrdered: time,
      timestamp: tempTime,
      userID: map[USER_ID].toString(),
      productIDList: List.from(map[PRODUCT_ID_LIST] as Iterable<dynamic>),
      totalAmount: int.parse(map[TOTAL_AMOUNT].toString()),
      isCompleted: map[IS_COMPLETED] as bool,
      isDelivered: map[IS_DELIVERED] as bool,
      paymentVerified: map[PAYMENT_VERIFIED] as bool,
      docID: map[DOC_ID].toString(),
      orderID: map[ORDER_ID].toString(),
      phoneNumber: map[PHONE_NUMBER].toString(),
      address: map[ADDRESS].toString(),
    );
  }
}
