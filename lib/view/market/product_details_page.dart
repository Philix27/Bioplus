part of 'product_image_carousel.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final CartController cartController =
      Get.put<CartController>(CartController());

  ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                product.productName!,
                style: Styles.headlineText1,
              ),
              // automaticallyImplyLeading: false,
              backgroundColor: Styles.canvasColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl![0],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Loading.spinKitThreeBounce(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
          color: Styles.canvasColor,
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: ListView(
            children: [
              MyWidgets.detailsRow(
                isEmpty: product.productName!.isEmpty,
                title: "Name: ${product.productName}",
              ),
              MyWidgets.detailsRow(
                isEmpty: !product.outOfStock!,
                title: "Product is out of stock",
              ),
              MyWidgets.detailsRow(
                  isEmpty: product.productPrice == null,
                  title:
                      "Price: ${MyGlobals.moneyFormater(product.productPrice!)}"),
              MyWidgets.detailsRow(
                icon: Icons.delete,
                isEmpty: false,
                title: "Delete this product",
                onPressed: () {
                  MyWidgets.bottomSheet(
                    Wrap(
                      children: [
                        ListTile(
                          title: Text(
                            'Confirm Delete',
                            style: Styles.headlineText2,
                          ),
                          onTap: () async {
                            await MyGlobals.productsCollection
                                .doc(product.productID)
                                .delete()
                                .then((value) {
                              MyWidgets.errorSnackbar('Deleted');
                            });
                            MyWidgets.getBack();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              if (!product.outOfStock!)
                MyWidgets.raisedButton(
                  title: "Add to cart",
                  color: Colors.blue,
                  onPressed: () {
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
                ),
              const SizedBox(height: 20),
              Text("More images", style: Styles.headlineText2),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: product.imageUrl!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // int index = index++;
                    return GestureDetector(
                      onTap: () => MyWidgets.goTo(
                        MoreImagePage(imageList: product.imageUrl!),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 0.36,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              product.imageUrl![index],
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
