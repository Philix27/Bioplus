import 'package:bioplus/core/styles.dart';
// import 'package:bioplus/core/theme_services.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
// import 'package:bioplus/view/market/market_page.dart';
import 'package:bioplus/view/market/product_controller.dart';
import 'package:bioplus/view/market/product_listtile.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopSearch extends SearchDelegate<Product> {
  ProductController controller = Get.find<ProductController>();
  CartController cartController = CartController();

  @override
  String get searchFieldLabel => 'Search';

  @override
  TextStyle get searchFieldStyle => Styles.bodyText2!;

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        hintStyle: Styles.bodyText2,
        contentPadding: const EdgeInsets.all(20),
        fillColor: Styles.canvasColor,
        focusColor: Styles.canvasColor,
        isCollapsed: true,
        filled: true,
        labelStyle: Styles.bodyText2,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => MyWidgets.getBack(),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> productList = query.isEmpty
        ? controller.productModelList.value
        : controller.productModelList.value.where((ho) {
            final string = ho.productName!.capitalize;

            return string!.contains(
                RegExp(query.capitalize!.trim(), caseSensitive: false));
          }).toList();

    return productList.isEmpty
        ? Center(child: Text('No result found', style: Styles.bodyText2))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final anHostel = productList[index];
              return ProductListTile(
                product: anHostel,
                cartController: cartController,
              );
            },
          );
  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeService().getThemeData().copyWith(
  //         inputDecorationTheme: InputDecorationTheme(
  //           contentPadding: const EdgeInsets.all(20),
  //           fillColor: Styles.canvasColor,
  //           focusColor: Styles.canvasColor,
  //           isCollapsed: true,
  //           filled: true,
  //           labelStyle: Styles.bodyText2,
  //         ),
  //       );
  // }
}
