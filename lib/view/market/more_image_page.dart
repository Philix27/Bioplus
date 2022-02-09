import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

class MoreImagePage extends StatelessWidget {
  final List<String> imageList;
  const MoreImagePage({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bioplus',
          style: Styles.headlineText1,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Styles.canvasColor,
      ),
      // body: Swiper(
      //   layout: SwiperLayout.STACK,
      //   itemHeight: MediaQuery.of(context).size.height,
      //   itemWidth: MediaQuery.of(context).size.width,
      //   itemCount: imageList.length,
      //   viewportFraction: 0.8,
      //   scale: 0.8,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Center(
      //       child: Container(
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: NetworkImage(
      //               imageList[index],
      //             ),
      //             fit: BoxFit.fitWidth,
      //           ),
      //           borderRadius: BorderRadius.circular(20),
      // ),
      // ),
      // );
      // },
      // ),
    );
  }
}
