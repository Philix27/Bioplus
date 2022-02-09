import 'package:flutter/foundation.dart';

// extends Equatable
class ProductCategoryModel {
  final String title;
  final String category;
  final bool hide;

  const ProductCategoryModel({
    required this.category,
    required this.title,
    required this.hide,
  });

  Map<String, dynamic> toMap() {
    return {
      'hide': hide,
      'title': title,
      'category': category,
    };
  }

  factory ProductCategoryModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ProductCategoryModel(
      // showProducts: false,
      title: map['title'].toString(),
      category: map['category'].toString(),
      hide: map['hide'] as bool,
    );
  }

  @override
  bool operator ==(dynamic other) =>
      other != null &&
      other is ProductCategoryModel &&
      this.category == other.category;

  @override
  int get hashCode => super.hashCode;

  @override
  // TODO: implement props
  List<Object> get props => [title, category];
}
