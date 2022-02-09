import 'package:bioplus/view/market/upload_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:bioplus/view/market/cart/cart_page.dart';
import 'package:bioplus/view/market/orders/all_orders_page.dart';
import 'package:bioplus/view/market/orders/orders_page.dart';
import 'package:bioplus/view/market/product_listtile.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:bioplus/view/widgets/widgets.dart';

part '../../router.dart/shop_popup_handler.dart';

class MarketPage extends StatelessWidget {
  final String displayCode;
  MarketPage({Key? key, required this.displayCode}) : super(key: key);
  final CartController cartController =
      Get.put<CartController>(CartController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: MyGlobals.productsCollection.orderBy("productName").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading.spinKitThreeBounce();
        } else if (snapshot.data!.docs.isEmpty) {
          return Container();
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot postDoc = snapshot.data!.docs[index];

              final Product product =
                  Product.fromMap(postDoc.data() as Map<String, dynamic>);

              if (displayCode == product.productCategory) {
                // MyGlobals.productsCollection
                //     .doc(product.productID)
                //     .update({"productCategory": "OTC"});

                return ProductListTile(
                  product: product,
                  cartController: cartController,
                );
              } else {
                return Container();
              }
            },
          );
        }
      },
    );
  }
}
