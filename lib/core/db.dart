import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DB {
  final int dof = 9;
  //! Main news section
  static final Query uniNews = FirebaseFirestore.instance
      .collection('UniversityNews')
      .orderBy('timePosted', descending: true);


//! Prev Banner
  static final Stream<QuerySnapshot> uniBanner = FirebaseFirestore.instance
      .collection('Banner')
      .where('category', isEqualTo: 'university')
      .snapshots();

  static final Stream<QuerySnapshot> mainBanner = FirebaseFirestore.instance
      .collection('Banner')
      .where('category', isEqualTo: 'main')
      .snapshots();

//! New

  static final Query uniBannerN = FirebaseFirestore.instance
      .collection('Banner')
      .doc('university')
      .collection('university')
      .where('expiryDate', isGreaterThanOrEqualTo: Timestamp.now());
  // .snapshots();

  static final Query mainBannerN = FirebaseFirestore.instance
      .collection('Banner')
      .doc('main')
      .collection('main')
      .where('expiryDate', isGreaterThanOrEqualTo: Timestamp.now());
  // .snapshots();

//! Past Questions
  static Stream<QuerySnapshot> getQuestionsStream({
    required String collectionName,
    required String docName,
  }) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docName)
          .collection("question")
          .orderBy('id', descending: true)
          .snapshots();

  static CollectionReference getCollectionReference({
    required String collectionName,
    required String docName,
  }) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docName)
          .collection("question");

//! Private users notification
  static Future<DocumentSnapshot> notificationList(String userID) =>
      FirebaseFirestore.instance.collection("Notification").doc(userID).get();
}
