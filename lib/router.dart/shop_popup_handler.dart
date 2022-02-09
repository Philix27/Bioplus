part of '../view/market/market_page.dart';

class ShopPopupHandler {
  int remove = 0;
  static const String add = 'Add';
  static const String profile = 'Profile';
  static const String orders = 'Orders';

  static List<String> choices = [
    add,
    profile,
    orders,
  ];

  static void choiceAction(String choice) {
    if (choice == add) {
      MyWidgets.getBack();
      Get.to(() => const ProductUploadPage());
    } else if (choice == profile) {
      MyWidgets.getBack();
      Get.to(() => OrderPage());
    } else if (choice == orders) {
      MyWidgets.getBack();
      Get.to(() => OrderPage());
    }
  }


  
}
