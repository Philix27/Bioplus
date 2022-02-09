class Product {
  final String? productName;
  final int? productPrice;
  final String? productDetails;
  final List<String>? imageUrl;
  final String? productID;
  final String? productCategory;
  int? quantityOrdered;
  bool? addedToCart;
  final bool? outOfStock;

  Product({
    this.outOfStock,
    this.productName,
    this.productPrice,
    this.productDetails,
    this.imageUrl,
    this.productID,
    required this.productCategory,
  });

  factory Product.fromMap(Map<String, dynamic> doc) {
    return Product(
      outOfStock: doc['outOfStock'] as bool,
      productName: doc['productName'].toString(),
      productDetails: doc['productDetails'].toString(),
      productID: doc['productID'].toString(),
      productPrice: int.parse(doc['productPrice'].toString()),
      imageUrl: List.from(doc['images'] as Iterable<dynamic>),
      productCategory: doc['productCategory'].toString(),
    );
  }
}
