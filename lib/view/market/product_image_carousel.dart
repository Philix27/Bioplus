import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/market/cart/cart_controller.dart';
import 'package:bioplus/view/market/more_image_page.dart';
import 'package:bioplus/view/market/product_model.dart';
import 'package:bioplus/view/widgets/widgets.dart';

import 'package:bioplus/view/widgets/launch_url.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart';

part 'product_details_page.dart';

class ProductImgCarosel extends StatelessWidget {
  final Future<QuerySnapshot> future;
  final bool reverse;

  ProductImgCarosel({
    required this.future,
    required this.reverse,
  });

  final CartController cartController =
      Get.put<CartController>(CartController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: FutureBuilder<QuerySnapshot>(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // return Loading.spinKitThreeBounce();
            return Container();
          } else {
            return Container();
            // return CarouselSlider.builder(
            //   options: CarouselOptions(
            //     reverse: reverse,
            //     autoPlay: true,
            //     viewportFraction: 0.45,
            //   ),
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (BuildContext context, int index, int u) {
            //     final DocumentSnapshot postDoc = snapshot.data!.docs[index];

            //     final Product product = Product.fromMap(postDoc.data() as Map<String , dynamic>);

            //     return Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(5.0),
            //         child: Material(
            //           elevation: 1.0,
            //           color: Styles.canvasColor,
            //           child: Column(
            //             children: [
            //               GestureDetector(
            //                 onTap: () => MyWidgets.goTo(
            //                     ProductDetailsPage(product: product)),
            //                 child: SizedBox(
            //                   height: 150,
            //                   width: 150,
            //                   child: CachedNetworkImage(
            //                     imageUrl: product.imageUrl![0],
            //                     fit: BoxFit.fill,
            //                     placeholder: (context, url) =>
            //                         Loading.spinKitThreeBounce(),
            //                     errorWidget: (context, url, error) =>
            //                         const Icon(Icons.error, color: Colors.red),
            //                   ),
            //                 ),
            //               ),
            //               if (product.outOfStock!)
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text("OS", style: Styles.headlineText2),
            //                 )
            //               else
            //                 Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         MyGlobals.moneyFormater(
            //                             product.productPrice!),
            //                         style: Styles.headlineText2,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
          }
        },
      ),
    );
  }
}
