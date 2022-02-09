import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/orders/order_controller.dart';
import 'package:bioplus/view/market/orders/ordered_items.dart';
import 'package:bioplus/view/market/orders/orders_model.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class AllOrdersPage extends StatelessWidget {
  final OrderController controller =
      Get.put<OrderController>(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Orders',
          style: Styles.headlineText2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: controller.allOrders().snapshots(),
          builder: (BuildContext context, snapshot) {
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
                    "Your have no orders",
                    style: Styles.bodyText2,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot snap = snapshot.data!.docs[index];
                  final OrdersM order = OrdersM.fromMap(snap.data() as Map<String , dynamic>);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Styles.canvasColor,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Address",
                              style: Styles.bodyText2,
                            ),
                            trailing: Text(
                              order.address!,
                              style: Styles.bodyText2,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Phone Number",
                              style: Styles.bodyText2,
                            ),
                            trailing: Text(
                              order.phoneNumber!,
                              style: Styles.bodyText2,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Order ID",
                              style: Styles.bodyText2,
                            ),
                            trailing: Text(
                              order.orderID!,
                              style: Styles.bodyText2,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Total amount",
                              style: Styles.bodyText2,
                            ),
                            trailing: Text(
                              MyGlobals.moneyFormater(order.totalAmount!),
                              style: Styles.bodyText2,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Time ordered",
                              style: Styles.bodyText2,
                            ),
                            subtitle: Text(
                              order.dateOrdered!,
                              style: Styles.bodyText2!.copyWith(fontSize: 10),
                            ),
                            trailing: Text(
                              MyGlobals.timestampDateStringFormatter(
                                  order.timestamp!),
                              style: Styles.bodyText2,
                            ),
                          ),
                          ListTile(
                            leading: Checkbox(
                              value: order.paymentVerified,
                              onChanged: (v) {
                                controller.updateVerifyPayment(
                                  order.paymentVerified!,
                                  order.docID!,
                                );
                              },
                            ),
                            tileColor: order.paymentVerified!
                                ? Colors.green
                                : Colors.orange,
                            title: Text(
                              "Payment verified",
                              style: Styles.bodyText2,
                            ),
                            trailing: order.paymentVerified!
                                ? const Icon(Icons.verified)
                                : const Icon(Icons.close),
                          ),
                          ListTile(
                            leading: Checkbox(
                              value: order.isDelivered,
                              onChanged: (v) {
                                controller.updateDelivered(
                                  order.isDelivered!,
                                  order.docID!,
                                );
                              },
                            ),
                            tileColor: order.isDelivered!
                                ? Colors.green
                                : Colors.orange,
                            title: Text(
                              "Delivered",
                              style: Styles.bodyText2,
                            ),
                            trailing: order.isCompleted!
                                ? const Icon(Icons.verified)
                                : const Icon(Icons.close),
                          ),
                          ListTile(
                            leading: Checkbox(
                              value: order.isCompleted,
                              onChanged: (v) {
                                controller.updateCompleted(
                                  order.isCompleted!,
                                  order.docID!,
                                );
                              },
                            ),
                            tileColor: order.isCompleted!
                                ? Colors.green
                                : Colors.orange,
                            title: Text(
                              "Completed",
                              style: Styles.bodyText2,
                            ),
                            trailing: order.isCompleted!
                                ? const Icon(Icons.verified)
                                : const Icon(Icons.close),
                          ),
                          ListTile(
                            title: Text(
                              "User ID",
                              style: Styles.bodyText2,
                            ),
                            trailing: Text(
                              order.userID!,
                              style: Styles.bodyText2,
                            ),
                          ),
                          ExpandablePanel(
                            // tapHeaderToExpand: true,
                            header: ListTile(
                              title: Text(
                                "Products",
                                style: Styles.bodyText2,
                              ),
                              trailing: Text(
                                "${order.productIDList!.length} Items",
                                style: Styles.bodyText2,
                              ),
                            ),
                            expanded: BuildOrderedItems(
                              docID: order.docID!,
                              orderController: controller,
                            ),
                            collapsed: Container(),

                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
