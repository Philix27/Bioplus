import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/core/app_users.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class AuthController extends GetxController {
  final UserController _userController = Get.put(UserController());
  late Rx<AppUser> _user;
  final googleSignIn = GoogleSignIn();
  Rx<bool> isSigningIn = Rx(false);
  final FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User> firebaseUser;
  User? get user => FirebaseAuth.instance.currentUser;
  // String get user => firebaseUser.value?.email;

  @override
  void onInit() {
    super.onInit();
    // _user.bindStream(_userController.userStream());
  }

  Future<void> registerEmail({
    required String email,
    required String password,
    required String phone,
    required String displayCode,
  }) async {
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // MyWidgets.snackbar(title: "Created");
        // value.printInfo(info: "Some Det: ");
        if (auth.currentUser != null) {
          MyGlobals.displayCode = displayCode;
          Get.off(() => HomePage(displayCode: displayCode));
          _userController.firstRegisterUser(phone);
        }
        MyWidgets.toast("Successful");
      });
    } catch (e) {
      if (e == "email-already-in-use") {
        MyWidgets.toast("Email Already in use");
      } else if (e == "operation-not-allowed") {
        MyWidgets.toast("Not allowed");
      } else if (e == "invalid-email") {
        MyWidgets.toast("Invalid Email");
      }
    }
  }

  Future<void> loginEmail({
    required String email,
    required String password,
    required String displayCode,
  }) async {
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (auth.currentUser != null) {
          MyGlobals.displayCode = displayCode;
          Get.off(() => HomePage(displayCode: displayCode));
        }
      });
    } catch (e) {
      if (e == "email-already-in-use") {
        MyWidgets.toast("Email Already in use");
      }
    }
  }

  Future<void> login() async {
    isSigningIn = Rx(true);

    GoogleSignInAccount? user;
    try {
      user = await googleSignIn.signIn();
    } on PlatformException {
      isSigningIn.value = false;

      isSigningIn.value = false;

      MyWidgets.snackbar(
        title: "Opps, an error occured",
        message: "Check your connection and try again",
        bgColor: Styles.warningColor,
      );
    } catch (error) {
      MyWidgets.errorSnackbar(error);
    }

    if (user == null) {
      isSigningIn = Rx(false);
      return;
    } else {
      final googleAuth = await user.authentication;
      try {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.additionalUserInfo!.isNewUser) {
            _userController.firstRegisterUser('');
          }
        });
      } catch (e) {
        MyWidgets.errorSnackbar(e);
      }

      isSigningIn = Rx(false);
    }
  }

  Future<void> logOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    // MyWidgets.goReplaceAll(SignInPage());
  }
}
