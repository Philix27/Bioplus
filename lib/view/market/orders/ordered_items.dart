import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/view/market/orders/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/product_image_carousel.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/widgets/loading.dart';

import 'ordered_product_m.dart';

class BuildOrderedItems extends StatelessWidget {
  final String docID;
  final OrderController orderController;
  const BuildOrderedItems({
    Key? key,
    required this.docID,
    required this.orderController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Shop-Orders')
          .doc(docID)
          .collection("products")
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Loading.spinKitFadingCircle();
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot snap = snapshot.data!.docs[index];
              final OrderedProduct product =
                  OrderedProduct.fromMap(snap.data() as Map<String , dynamic>);

              return OrderedItems(
                productID: product.id!,
                orderedProduct: product,
                orderController: orderController,
                orderDocID: docID,
              );
            },
          );
        }
      },
    );
  }
}

class OrderedItems extends StatelessWidget {
  final String productID;
  final String orderDocID;

  final OrderedProduct orderedProduct;
  final OrderController orderController;

  const OrderedItems({
    Key? key,
    required this.productID,
    required this.orderedProduct,
    required this.orderDocID,
    required this.orderController,
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
                  } else {
                    final Product product =
                        Product.fromMap(snapshot.data!.data() as Map<String , dynamic>);

                    return Column(
                      children: [
                        ListTile(
                          tileColor: Styles.canvasColor,
                          onTap: () => Get.to(
                              () => ProductDetailsPage(product: product)),
                          title: Text(
                            "${product.productName}  x${orderedProduct.quantity}",
                            style: Styles.headlineText2,
                          ),
                          subtitle: Text(
                            MyGlobals.moneyFormater(orderedProduct.price!),
                            style: Styles.headlineText2!.copyWith(fontSize: 10),
                          ),
                          trailing: Text(
                            MyGlobals.moneyFormater(orderedProduct.totalPrice!),
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
                        if (Get.find<UserController>()
                            .user
                            .adminTypes
                            .contains("Product")
                        // .contains("Product") ??
                        )
                          ListTile(
                            leading: Checkbox(
                              value: orderedProduct.isDelivered,
                              onChanged: (v) {
                                orderController.updateDeliveredProduct(
                                  orderedProduct.isDelivered!,
                                  orderDocID,
                                  productID,
                                );
                              },
                            ),
                            tileColor: orderedProduct.isDelivered!
                                ? Colors.green
                                : Colors.orange,
                            title: Text(
                              "Delivered",
                              style: Styles.bodyText2,
                            ),
                            trailing: orderedProduct.isDelivered!
                                ? const Icon(Icons.verified)
                                : const Icon(Icons.close),
                          )
                        else
                          ListTile(
                            tileColor: orderedProduct.isDelivered!
                                ? Colors.green
                                : Colors.orange,
                            title: Text(
                              "Delivered",
                              style: Styles.bodyText2,
                            ),
                            trailing: orderedProduct.isDelivered!
                                ? const Icon(Icons.verified)
                                : const Icon(Icons.close),
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
    );
  }
}
