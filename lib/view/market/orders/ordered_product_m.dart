import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrderedProduct {
  final String? id;
  final int? quantity;
  final int? price;
  final int? totalPrice;
  final bool? isDelivered;
  final bool isReceived;

  OrderedProduct({
    required this.id,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.isDelivered,
    required this.isReceived,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'isDelivered': isDelivered,
      'isReceived': isReceived,
    };
  }

  factory OrderedProduct.fromMap(Map<String, dynamic> map) {
    return OrderedProduct(
      id: map['id'].toString(),
      quantity: int.tryParse(map['quantity'].toString()),
      price: int.tryParse(map['price'].toString()),
      totalPrice: int.tryParse(map['totalPrice'].toString()),
      isDelivered: map['isDelivered'] as bool,
      isReceived: map['isReceived'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
