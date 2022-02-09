import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// import 'package:upgrader/upgrader.dart';

class MyGlobals {
  static late String displayCode;
  static final CollectionReference pQuestions =
      FirebaseFirestore.instance.collection('pastQuestions');

  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static final CollectionReference suggestionCollection =
      FirebaseFirestore.instance.collection('suggestions');

  static final CollectionReference otherNewsCollection =
      FirebaseFirestore.instance.collection('otherNews');

  static final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection('ExpensesMade');
  static final CollectionReference dailySalesNoteCollection =
      FirebaseFirestore.instance.collection('DailySalesNote');
  static final CollectionReference drugsNeededCollection =
      FirebaseFirestore.instance.collection('DrugsNeeded');

  static final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');
  static final CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('ShoppingCart');

//FirebaseStorage
  static final Reference postPictures =
      FirebaseStorage.instance.ref().child('postpictures');

  static final Reference profilePictures =
      FirebaseStorage.instance.ref().child('profilePics');

  static final Reference productPictures =
      FirebaseStorage.instance.ref().child('productPictures');

  static final Reference bannerPictures =
      FirebaseStorage.instance.ref().child('bannerPictures');

  static final Reference locationPictures =
      FirebaseStorage.instance.ref().child('locationPictures');

  static final Reference pqUnorganised =
      FirebaseStorage.instance.ref().child('pqUnorganised');

  static final Reference businessCoverImages =
      FirebaseStorage.instance.ref().child('businessCoverImages');

  static final Reference hostelImages =
      FirebaseStorage.instance.ref().child('Hostel');

  static Reference groupchatStorage(String groupName) =>
      FirebaseStorage.instance.ref().child(groupName);

  static final User firebaseCurrentUser = FirebaseAuth.instance.currentUser!;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static String phoneNumber = '';

  static final RegExp _regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  static String moneyFormater(int value) =>
      "₦$value".replaceAllMapped(_regExp, (Match m) => '${m[1]},');

  static List<Widget> productsCategoryList = [];

//? Pricing
  static String publicKey = "pk_live_bcddf6973cdcbd5811ae519ab726adb9cce4091f";

  static String timestampDateStringFormatter(Timestamp timestamp) =>
      DateFormat.yMMMMd().format(timestamp.toDate());

  bool hideBottomNavbar = false;
}
