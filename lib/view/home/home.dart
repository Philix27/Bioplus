import 'package:bioplus/services/local_not_serv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/view/market/cart/cart_page.dart';
import 'package:get/get.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/market_page.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  final String displayCode;
  const HomePage({Key? key, required this.displayCode}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    //? Opens the app from a terminated state
    FirebaseMessaging.instance.getInitialMessage().then((_) {
      print("on getInitialMessage Called r67");
      final String v = _!.data["open"].toString();
      if (v == "cart") {
        Get.to(CartPage(displayCode: widget.displayCode));
      }
    });

    //? Called while the app is in foreground
    FirebaseMessaging.onMessage.listen((_m) {
      if (_m.notification != null) {
        print("on message Called r67");
        print(_m.notification!.body);
        print(_m.notification!.title);
        print("_m.notification!.title");

        LocalNotificationService.display(_m);
      }
    });

    //? Called when the app is opened but is not on foreground
    FirebaseMessaging.onMessageOpenedApp.listen((_) {
      print("on onMessageOpenedApp Called r67");
      final String v = _.data["open"].toString();

      if (v == "cart") {
        Get.to(() => CartPage(displayCode: widget.displayCode));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          bottomOpacity: 0,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Bioplus",
            style: Styles.headlineText3,
          ),
          actions: [
            getPopUp(
              choices: ShopPopupHandler.choices,
              onSelected: ShopPopupHandler.choiceAction,
            ),
          ],
        ),
        floatingActionButton: MyWidgets.fab(
          icon: Icons.shopping_basket,
          onTap: () {
            Get.to(() => CartPage(displayCode: widget.displayCode));
          },
        ),
        body: MarketPage(displayCode: widget.displayCode),
      );
}

Widget getPopUp({
  required Function(String) onSelected,
  required List<String> choices,
}) {
  return PopupMenuButton(
    onSelected: onSelected,
    icon: const Icon(
      Icons.more_vert_rounded,
      color: Colors.white,
    ),
    color: Colors.white,
    itemBuilder: (BuildContext context) {
      return choices
          .map(
            (String choice) => PopupMenuItem(
              value: choice,
              child: Text(
                choice,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.headlineText2,
              ),
            ),
          )
          .toList();
    },
  );
}
