import 'package:flutter/cupertino.dart';
import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyWidgets {
  static Widget raisedButton({
    VoidCallback? onPressed,
    required String title,
    Color? color,
  }) {
    return RaisedButton(
      onPressed: onPressed,
      color: color ?? Styles.primaryColor,
      textColor: Styles.canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          title,
          style: Styles.headlineText4,
        ),
      ),
    );
  }

  static Future<dynamic>? goTo(Widget page) {
    return Get.to(
      () => page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  static Future<dynamic>? goReplaceAll(Widget page) {
    return Get.offAll(
      page,
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  static void getBack() => Get.back();

//? Snackbar
  static void snackbar({
    required String title,
    String message = '',
    Color? bgColor,
  }) {
    return Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 13.5,
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor ?? Colors.blue[700],
      borderRadius: 10,
    );
  }

  static void errorSnackbar(dynamic title) {
    const String message = '';

    return Get.snackbar(
      title.toString(),
      message,
      titleText: Text(
        title.toString(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: Styles.headlineText4,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Styles.warningColor,
      borderRadius: 10,
    );
  }

//? Alert Dialog
  static Future<dynamic> alertDialog({
    String? title,
    Widget? content,
    VoidCallback? cancelCallback,
    VoidCallback? confirmCallback,
  }) {
    return Get.defaultDialog(
      title: title!,
      titleStyle: Styles.headlineText2,
      content: content,
      backgroundColor: Styles.canvasColor,
      radius: 10,
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      // cancel: raisedButton(
      //   title: 'Cancel',
      //   color: Colors.blue[700],
      //   onPressed: confirmCallback,
      // ),
      // confirm: raisedButton(
      //   title: 'Confirm',
      //   color: Colors.blue[700],
      //   onPressed: cancelCallback,
      // ),
      onCancel: cancelCallback,
      onConfirm: confirmCallback,
      barrierDismissible: false,
    );
  }

  static Future<dynamic> selectAlertDialog({
    required String title,
    required Widget content,
  }) {
    return Get.defaultDialog(
      title: title,
      titleStyle: Styles.headlineText1,
      content: content,
      backgroundColor: Styles.canvasColor,
      radius: 10,
      textCancel: 'Cancel',
      onCancel: () {},
      barrierDismissible: false,
    );
  }

  static Future dialog(Widget widget) {
    return Get.dialog(
      widget,
      transitionCurve: Curves.easeInOutCirc,
    );
  }
//? Bottom Bar

  static Future<dynamic> infoBS(String info) {
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20,
        ),
        child: Text(
          info,
          style: Styles.bodyText2,
        ),
      ),
      backgroundColor: Styles.canvasColor,
      isDismissible: true,
    );
  }

  static Future<dynamic> bottomSheet(Widget widget) {
    return Get.bottomSheet(
      widget,
      backgroundColor: Styles.canvasColor,
      isDismissible: true,
    );
  }

  static Widget detailsRow({
    required String title,
    required bool isEmpty,
    IconData? icon,
    VoidCallback? onPressed,
  }) {
    if (!isEmpty) {
      return Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(title, style: Styles.bodyText2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                  icon: Icon(icon, color: Styles.primaryColor),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
          Divider(
            color: Styles.backgroundColor,
            thickness: 2.0,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
//! Floating action button

  static Widget fab({
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    IconData? icon,
  }) {
    return SizedBox(
      height: 50,
      width: 50,
      child: InkWell(
        onLongPress: onLongPress,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Styles.primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Icon(
              icon,
              color: Styles.canvasColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  static dynamic toast(String msg) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Styles.primaryColor,
      textColor: Styles.canvasColor,
      fontSize: 14.0);

  static void showCupertino(
    BuildContext context, {
    required Widget? child,
    required VoidCallback? onPressed,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [child!],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onPressed!,
            child: Text(
              "Done",
              style: Styles.headlineText4,
            ),
          ),
        ),
      );
}
