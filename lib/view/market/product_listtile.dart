import 'package:cached_network_image/cached_network_image.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/market/product_image_carousel.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    Key? key,
    required this.product,
    required this.cartController,
  }) : super(key: key);

  final Product product;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 105,
          decoration: BoxDecoration(
            color: Styles.canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () =>
                        MyWidgets.goTo(ProductDetailsPage(product: product)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl![0],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Loading.spinKitFadingCircle(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              product.productName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.bodyText1!.copyWith(
                                fontSize: 15,
                                color: product.outOfStock!
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ),
                          Text(
                            MyGlobals.moneyFormater(product.productPrice!),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.headlineText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  if (!product.outOfStock!) {
                    cartController.addCartItem(
                      product.productID!,
                      product.productPrice!,
                      product.productCategory!,
                    );
                  } else {
                    MyWidgets.snackbar(
                        title: "Product is currently out of stock");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Styles.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: Styles.canvasColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
