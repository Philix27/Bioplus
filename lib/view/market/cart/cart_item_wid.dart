import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/cart/cart_item_model.dart';
import 'package:bioplus/view/market/product_image_carousel.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/widgets/loading.dart';

import 'bottom_cart_tray.dart';
import 'cart_item_model.dart';

class CartItemWid extends StatelessWidget {
  final String productID;
  final CartItem cartItem;
  final int widgetIndex;
  final CartController cartController;

  const CartItemWid({
    Key? key,
    required this.cartItem,
    required this.productID,
    required this.widgetIndex,
    required this.cartController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 4.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Dismissible(
            key: Key(UniqueKey().toString()),
            onDismissed: (direction) {
              cartController.deleteCartItem(
                cartItem.productID!,
                cartItem.quantity!,
                MyGlobals.displayCode,
              );
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Styles.warningColor,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('Products')
                      .doc(productID)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Loading.spinKitFadingCircle();
                      // return Container();
                    } else {
                      final Product product = Product.fromMap(
                          snapshot.data!.data() as Map<String, dynamic>);
                      final int productTotal =
                          product.productPrice! * cartItem.quantity!;
                      return Column(
                        children: [
                          ListTile(
                            tileColor: Styles.canvasColor,
                            onTap: () => Get.to(
                                () => ProductDetailsPage(product: product)),
                            title: Text(product.productName!,
                                style: Styles.headlineText2),
                            subtitle: Text(
                              MyGlobals.moneyFormater(product.productPrice!),
                              style:
                                  Styles.headlineText2!.copyWith(fontSize: 10),
                            ),
                            trailing: Text(
                              MyGlobals.moneyFormater(productTotal),
                              style: Styles.headlineText2,
                            ),
                            leading: SizedBox(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrl![0],
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Container(color: Styles.primaryColor),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                              ),
                            ),
                          ),
                          BottomTray(
                            product: product,
                            cartItem: cartItem,
                            productTotal: productTotal,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
