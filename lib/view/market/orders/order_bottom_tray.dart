import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:bioplus/view/market/orders/ordered_product_m.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/core/styles.dart';
// import 'package:bioplus/view/market/cart/cart_page.dart';

class OrderBottomTray extends StatefulWidget {
  const OrderBottomTray({Key? key, required this.orderedProduct})
      : super(key: key);

  final OrderedProduct orderedProduct;

  @override
  _OrderBottomTrayState createState() => _OrderBottomTrayState();
}

class _OrderBottomTrayState extends State<OrderBottomTray> {
  bool checkBoxIsSelected = false;
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    // CartItem ctItm;

    return Column(
      children: [
        ListTile(
          leading: Checkbox(
            value: widget.orderedProduct.isDelivered,
            onChanged: (v) {
              // controller.updateVerifyPayment(
              //   order.paymentVerified,
              //   order.docID,
              // );
            },
          ),
          tileColor:
              widget.orderedProduct.isDelivered! ? Colors.green : Colors.orange,
          title: Text(
            "Payment verified",
            style: Styles.bodyText2,
          ),
          trailing: widget.orderedProduct.isDelivered!
              ? const Icon(Icons.verified)
              : const Icon(Icons.close),
        ),
        ListTile(
          leading: Checkbox(
            value: widget.orderedProduct.isDelivered,
            onChanged: (v) {
              // controller.updateDelivered(
              //   order.isDelivered,
              //   order.docID,
              // );
            },
          ),
          tileColor:
              widget.orderedProduct.isDelivered! ? Colors.green : Colors.orange,
          title: Text(
            "Delivered",
            style: Styles.bodyText2,
          ),
          trailing: widget.orderedProduct.isDelivered!
              ? const Icon(Icons.verified)
              : const Icon(Icons.close),
        ),
        ListTile(
          leading: Checkbox(
            value: widget.orderedProduct.isDelivered,
            onChanged: (v) {
              // controller.updateCompleted(
              //   order.isCompleted,
              //   order.docID,
              // );
            },
          ),
          tileColor:
              widget.orderedProduct.isDelivered! ? Colors.green : Colors.orange,
          title: Text(
            "Completed",
            style: Styles.bodyText2,
          ),
          trailing: widget.orderedProduct.isDelivered!
              ? const Icon(Icons.verified)
              : const Icon(Icons.close),
        ),
      ],
    );
  }
}
