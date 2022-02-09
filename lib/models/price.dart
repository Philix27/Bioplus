class Price {
  final int? duration;
  final int? price;
  final String title;
  const Price({
    required this.duration,
    required this.price,
    required this.title,
  });

  factory Price.fromMap(Map<String, dynamic> doc) {
    return Price(
      title: doc['Title'].toString(),
      duration: int.tryParse(doc['Duration'].toString()),
      price: int.tryParse(doc['Price'].toString()),
    );
  }
}
