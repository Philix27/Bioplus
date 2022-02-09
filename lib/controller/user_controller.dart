import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/core/app_users.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class UserController extends GetxController {
  // ignore: use_late_for_private_fields_and_variables
  late Rx<AppUser> _user;
  //  = AppUser().obs;
  AppUser get user => _user.value;

  // @override
  // void onInit() {
  //   _user.bindStream(userStream());
  // }

  Stream<AppUser> userStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) {
      return AppUser.fromMap(event.data()!);
    });
  }

  Future<bool> isUserRegistered(String userID) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .snapshots()
        .isEmpty;
  }

  Future<void> firstRegisterUser(String phonenumber) async {
    final Map<String, dynamic> docMap = {
      'uid': MyGlobals.firebaseCurrentUser.uid,
      'username': MyGlobals.firebaseCurrentUser.displayName,
      'profilePic': MyGlobals.firebaseCurrentUser.photoURL,
      'email': MyGlobals.firebaseCurrentUser.email,
      'adminTypes': ['User'],
      'timeCreated': Timestamp.now(),
      'access': [],
      'groupKeys': [],
      'verified': false,
      'phoneNumber': phonenumber,
    };

    MyGlobals.userCollection
        .doc(MyGlobals.firebaseCurrentUser.uid)
        .set(docMap)
        .then(
      (value) async {
        MyWidgets.snackbar(
          title: 'Successful',
          message: 'Registration completed',
        );
        // MyWidgets.goReplaceAll(HomePage());
      },
    );
  }

  //! We need to move =>
  //? New Section

  DocumentSnapshot? userDoc;
  Rx<List<String>> urlValue = Rx<List<String>>([]);

  Future<void> updateUserPhoneNumber({
    required String uid,
    required String username,
    required String phoneNumber,
  }) async {
    final Map<String, dynamic> docMap = {
      'username': username,
      'phoneNumber': phoneNumber,
    };

    await MyGlobals.userCollection.doc(uid).update(docMap).then(
      (value) async {
        MyWidgets.snackbar(
          title: 'Successful',
          message: 'Profile updated',
          bgColor: Styles.primaryColor,
        );
      },
    );
  }

  Future<void> saveUserPhoneNumber({
    required String uid,
    required String phoneNumber,
  }) async {
    await MyGlobals.userCollection
        .doc(uid)
        .update({'phoneNumber': phoneNumber}).then(
      (value) async {
        MyWidgets.snackbar(
          title: 'Successful',
          message: 'Contact Info updated',
          bgColor: Styles.primaryColor,
        );
      },
    );
  }
}
