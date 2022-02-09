import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'package:bioplus/controller/payment_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/market/orders/order_controller.dart';
import 'package:bioplus/view/market/orders/ordered_product_m.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/widgets.dart';


TextEditingController phoneNumberCont = TextEditingController();
TextEditingController addressCont = TextEditingController();
final OrderController orderController =
    Get.put<OrderController>(OrderController());
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

Widget checkoutListTile(
  BuildContext context, {
  required PaymentController paymentController,
  required PaystackPlugin plugin,
  required int total,
  required List<String> productIDList,
  required List<OrderedProduct> orderedProductList,
}) {
  return ExpandablePanel(
    // tapHeaderToExpand: true,
    // hasIcon: false,
    theme: const ExpandableThemeData(
      hasIcon: false,
      useInkWell: true,
    ),
    header: ListTile(
      tileColor: Styles.primaryColor,
      title: Center(
        child: Text(
          "Checkout",
          style: Styles.headlineText4,
        ),
      ),
    ),
    expanded: Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 25,
        bottom: 20,
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              'Deliveries will be done only within Abraka - Delta State',
              softWrap: true,
              style: Styles.bodyText1,
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phoneNumberCont,
                  maxLength: 11,
                  style: Styles.bodyText2,
                  decoration: const InputDecoration(
                    hintText: 'Phone number: 08100000000',
                  ),
                  validator: (value) {
                    if (value!.length < 11) {
                      return 'Must be a complete phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: addressCont,
                  maxLines: 10,
                  minLines: 4,
                  maxLength: 100,
                  style: Styles.bodyText2,
                  decoration: const InputDecoration(
                    hintText: 'Hostel/Lodge address...',
                  ),
                  validator: (value) {
                    if (value!.length > 100) {
                      return 'Address too long';
                    } else if (value.length < 7) {
                      return "Please type an address";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MyWidgets.raisedButton(
            title: "PAY",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                // orderController.addAnOrder(
                //   oProd: orderedProductList,
                //   totalAmount: total,
                //   productIDList: productIDList,
                //   phoneNumber: phoneNumberCont.text.trim(),
                //   address: addressCont.text.trim(),
                // );
                // TODO Attend to the commented code below
                paymentController.payAndUpload(
                  context,
                  purpose: "Product",
                  plugin: plugin,
                  price: total,
                  successCallback: () {
                    orderController
                        .addAnOrder(
                      oProd: orderedProductList,
                      totalAmount: total,
                      productIDList: productIDList,
                      phoneNumber: phoneNumberCont.text.trim(),
                      address: addressCont.text.trim(),
                      displayCode: MyGlobals.displayCode,
                    )
                        .then((value) {
                      phoneNumberCont.clear();
                      addressCont.clear();
                    });
                  },
                );
              }
            },
          ),
        ],
      ),
    ),
    collapsed: Container(),
  );
}
