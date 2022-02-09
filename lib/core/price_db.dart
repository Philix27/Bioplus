import 'package:cloud_firestore/cloud_firestore.dart';

class PriceDB {
  int none = 0;
  static final Stream<QuerySnapshot> newsS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('news')
      .collection('pricing')
      .snapshots();
  static final Stream<QuerySnapshot> uniNewsS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('uniNews')
      .collection('pricing')
      .snapshots();

  static final Future<QuerySnapshot> newsF = FirebaseFirestore.instance
      .collection('pricing')
      .doc('news')
      .collection('pricing')
      .get();
  static final Future<QuerySnapshot> productF = FirebaseFirestore.instance
      .collection('pricing')
      .doc('product')
      .collection('pricing')
      .get();
  static final Stream<QuerySnapshot> productS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('product')
      .collection('pricing')
      .snapshots();
  static final Future<QuerySnapshot> bannerF = FirebaseFirestore.instance
      .collection('pricing')
      .doc('banner')
      .collection('pricing')
      .get();

  static Future<DocumentSnapshot> bannerC =
      FirebaseFirestore.instance.collection('pricing').doc('banner').get();

  static final Stream<QuerySnapshot> bannerS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('banner')
      .collection('pricing')
      .snapshots();
  static final Future<QuerySnapshot> businessF = FirebaseFirestore.instance
      .collection('pricing')
      .doc('business')
      .collection('pricing')
      .get();
  static final Stream<QuerySnapshot> businessS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('business')
      .collection('pricing')
      .snapshots();
  static final Future<QuerySnapshot> locationF = FirebaseFirestore.instance
      .collection('pricing')
      .doc('location')
      .collection('pricing')
      .get();
  static final Stream<QuerySnapshot> locationS = FirebaseFirestore.instance
      .collection('pricing')
      .doc('location')
      .collection('pricing')
      .snapshots();
}
