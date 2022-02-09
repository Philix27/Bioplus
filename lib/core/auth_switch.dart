// import 'package:bioplus/core/remote_config.dart';

import 'package:bioplus/view/auth/auth_controller.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:bioplus/controller/user_controller.dart';

class AuthSwitch extends GetWidget<AuthController> {
  final AuthController authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    //! Assign Themes
    Styles.primaryColor = Theme.of(context).primaryColor;
    Styles.accentColor = Theme.of(context).accentColor;
    Styles.canvasColor = Theme.of(context).canvasColor;
    Styles.scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Styles.backgroundColor = Theme.of(context).backgroundColor;
    Styles.bodyText1 = Theme.of(context).textTheme.bodyText1;
    Styles.bodyText2 = Theme.of(context).textTheme.bodyText2;
    Styles.subtitle1 = Theme.of(context).textTheme.subtitle1;
    Styles.subtitle2 = Theme.of(context).textTheme.subtitle2;
    Styles.headlineText1 = Theme.of(context).textTheme.headline1;
    Styles.headlineText2 = Theme.of(context).textTheme.headline2;
    Styles.headlineText3 = Theme.of(context).textTheme.headline3;
    Styles.headlineText4 = Theme.of(context).textTheme.headline4;
    return SignInPage();
    // return Obx(
    //   () {
    //     if (authController.user == null) {
    //       // _userController.userB.bindStream(_userController.userStream());
    //       // if (_userController.userB.value != null) {
    //       return const HomePage();
    //       // } else {
    //       // return View();
    //       // }
    //     } else {
    //       return SignInPage();
    //     }
    //   },
    // );
  }
}
