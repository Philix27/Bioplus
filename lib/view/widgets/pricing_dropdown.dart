// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bioplus/models/price.dart';
// import 'package:bioplus/utils/global_variables.dart';
// import 'package:bioplus/utils/styles.dart';
// import 'package:flutter/material.dart';

// import 'package:bioplus/view/widgets/loading.dart';

// class PricingDropdown extends StatefulWidget {
//   final Stream<QuerySnapshot> stream;
//   const PricingDropdown({
//     Key key,
//     this.stream,
//   }) : super(key: key);
//   @override
//   _PricingDropdownState createState() => _PricingDropdownState();
// }

// class _PricingDropdownState extends State<PricingDropdown> {
//   String selectedprice;
//   String regDuration;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: widget.stream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Loading.spinKitThreeBounce();
//         } else {
//           final List<DropdownMenuItem> regPrice = [];

//           for (int i = 0; i < snapshot.data.docs.length; i++) {
//             final DocumentSnapshot snap = snapshot.data.docs[i];
//             final Price price = Price.fromDocumentSnapshot(snap);
//             regPrice.add(
//               DropdownMenuItem(
//                 value: price.price,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       price.title,
//                       // snap['Duration'].toString(),
//                       style: Styles.bodyText2,
//                     ),
//                     const SizedBox(width: 20),
//                     Text(
//                       "₦${price.price}"
//                           .replaceAllMapped(regExp, (Match m) => '${m[1]},'),
//                       style: Styles.bodyText2,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // const SizedBox(width: 50.0),
//               DropdownButton(
//                 isDense: true,
//                 items: regPrice,
//                 onChanged: (priceValue) {
//                   setState(() {
//                     selectedprice = priceValue.toString();
//                     newsPricing = priceValue.toString();
//                   });
//                 },
//                 value: selectedprice,
//                 hint: Text("Choose Plan", style: Styles.bodyText2),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
