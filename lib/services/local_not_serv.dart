import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/market/cart/cart_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  int op = 0;
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialise() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("assets/icon/icon.png"));

    _notificationPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        if (payload == "cart") {
          Get.to(() => CartPage(displayCode: MyGlobals.displayCode));
        }
      }
    });
  }

  static Future<void> display(RemoteMessage m) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "bioplus",
          "Bioplus",
          "Bioplus Channel",
          importance: Importance.high,
          priority: Priority.high,
        ),
      );

      await _notificationPlugin.show(
        id,
        m.notification!.title,
        m.notification!.body,
        notificationDetails,
        payload: m.data["open"].toString(),
      );
    } on Exception catch (e) {
      print("Error: $e");
    }
  }
}
