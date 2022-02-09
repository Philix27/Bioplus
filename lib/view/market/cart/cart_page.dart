import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'package:bioplus/controller/payment_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/market/cart/cart_item_wid.dart';
import 'package:bioplus/view/market/cart/total_tile.dart';
import 'package:bioplus/view/market/orders/order_controller.dart';
import 'package:bioplus/view/market/orders/ordered_product_m.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/cart/cart_item_model.dart';
import 'package:bioplus/view/widgets/loading.dart';

import 'cart_checkout.dart';
import 'cart_controller.dart';
import 'cart_item_model.dart';

class CartPage extends StatefulWidget {
  final String displayCode;
  const CartPage({
    Key? key,
    required this.displayCode,
  }) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController controller = Get.put<CartController>(CartController());
  final OrderController orderController =
      Get.put<OrderController>(OrderController());
  PaymentController? paymentController;
  PaystackPlugin paystackPlugin = PaystackPlugin();
  @override
  void initState() {
    super.initState();
    paystackPlugin.initialize(publicKey: MyGlobals.publicKey);
    paymentController = PaymentController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: Styles.headlineText4,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.getCartList(widget.displayCode).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Loading.spinKitFadingCircle(),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    "Your cart is empty",
                    style: Styles.bodyText2,
                  ),
                ),
              );
            } else {
              int sum = 0;
              int counter = 0;
              final List<String> selectedProductIDList = [];
              final List<OrderedProduct> orderedProductList = [];
              final int numberOfItems = snapshot.data!.docs.length;

              snapshot.data!.docs.forEach((v) {
                CartItem ci =
                    CartItem.fromMap(v.data() as Map<String, dynamic>);

                if (ci.isSelected!) {
                  sum = sum + ci.productPrice! * ci.quantity!;
                  selectedProductIDList.add(ci.productID!);
                  orderedProductList.add(OrderedProduct(
                    id: ci.productID,
                    isDelivered: false,
                    totalPrice: sum,
                    price: ci.productPrice,
                    quantity: ci.quantity,
                    isReceived: false,
                  ));
                  counter++;
                }
              });

              // final int deliveryFee = 200 * counter;
              final int deliveryFee = 200;
              final int grandTotal = sum + deliveryFee;
              return Column(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot snap = snapshot.data!.docs[index];
                      final CartItem cartItem =
                          CartItem.fromMap(snap.data() as Map<String, dynamic>);

                      return CartItemWid(
                        widgetIndex: index,
                        productID: cartItem.productID!,
                        cartItem: cartItem,
                        cartController: controller,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: Styles.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          if (numberOfItems == 1)
                            totalTile(
                              leading: 'Cart items',
                              trailing: '$numberOfItems item',
                            )
                          else
                            totalTile(
                              leading: 'Cart items',
                              trailing: '$numberOfItems items',
                            ),
                          if (counter == 1)
                            totalTile(
                              leading: 'Selected items',
                              trailing: '$counter item',
                            )
                          else
                            totalTile(
                              leading: 'Selected items',
                              trailing: '$counter items',
                            ),
                          totalTile(
                            leading: 'Total -Selected',
                            trailing: MyGlobals.moneyFormater(sum),
                          ),
                          totalTile(
                            leading: 'Delivery Fee',
                            trailing: MyGlobals.moneyFormater(deliveryFee),
                          ),
                          totalTile(
                            leading: 'Grand Total',
                            trailing: MyGlobals.moneyFormater(grandTotal),
                            makeBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (selectedProductIDList.isNotEmpty)
                    checkoutListTile(
                      context,
                      orderedProductList: orderedProductList,
                      total: grandTotal,
                      productIDList: selectedProductIDList,
                      paymentController: paymentController!,
                      plugin: paystackPlugin,
                    ),
                  const SizedBox(height: 30),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
