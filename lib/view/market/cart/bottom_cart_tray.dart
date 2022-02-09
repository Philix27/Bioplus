import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:flutter/material.dart';

import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/cart/cart_item_model.dart';
// import 'package:bioplus/view/market/cart/cart_page.dart';

class BottomTray extends StatefulWidget {
  const BottomTray({
    Key? key,
    required this.cartItem,
    required this.productTotal,
    required this.product,
  }) : super(key: key);

  final CartItem cartItem;
  final int productTotal;
  final Product product;

  @override
  _BottomTrayState createState() => _BottomTrayState();
}

class _BottomTrayState extends State<BottomTray> {
  // bool checkBoxIsSelected = false;
  final CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    // CartItem ctItm;

    return Container(
      height: 40,
      color: Styles.primaryColor,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                cartController.deleteCartItem(
                  widget.cartItem.productID!,
                  widget.cartItem.quantity!,
                  MyGlobals.displayCode,
                );
              },
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                cartController.decrementCartItem(
                  widget.cartItem.productID!,
                  widget.cartItem.quantity!,
                  widget.productTotal,
                  MyGlobals.displayCode,
                );
              },
              child: Container(
                color: Colors.orange,
                child: const Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  widget.cartItem.quantity.toString(),
                  style: Styles.bodyText2!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                cartController.incrementCartItem(
                  widget.cartItem.productID!,
                  widget.cartItem.quantity!,
                  widget.productTotal,
                  MyGlobals.displayCode,
                );
              },
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (!widget.product.outOfStock!)
            Expanded(
              child: Container(
                color: Colors.amber,
                child: Center(
                  child: Checkbox(
                    activeColor: Colors.blue[700],
                    checkColor: Colors.white,
                    value: widget.cartItem.isSelected,
                    onChanged: (v) {
                      cartController.updateIsSelected(
                        productID: widget.cartItem.productID!,
                        isSelected: v!,
                      category:  MyGlobals.displayCode,
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
