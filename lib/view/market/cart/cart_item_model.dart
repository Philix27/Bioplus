import 'package:flutter/foundation.dart';

class CartItem {
  final int? quantity;
  final int? productPrice;
  final String? productID;
  final bool? isSelected;

  CartItem({
    required this.quantity,
    required this.productPrice,
    required this.productID,
    required this.isSelected,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'productID': productID,
      'isSelected': productID,
      'productPrice': productPrice,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: int.tryParse(map['quantity'].toString()),
      productPrice: int.tryParse(map['productPrice'].toString()),
      productID: map['productID'].toString(),
      isSelected: map['isSelected'] as bool,
    );
  }
}
