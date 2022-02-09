// import 'package:bioplus/core/styles.dart';
// import 'package:bioplus/view/market/orders/ordered_product.dart';
// import 'package:flutter/material.dart';


// Future<void> paymentForm(
//     {required int total,
//     required List<String> productIDList,
//     required List<OrderedProduct> orderedProductList}) {
//   return MyWidgets.bottomSheet(
//     Padding(
//       padding: const EdgeInsets.only(
//         left: 10.0,
//         right: 10.0,
//         top: 20,
//         bottom: 10,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 20.0,
//             right: 20.0,
//             top: 10,
//             bottom: 10,
//           ),
//           child: Column(
//             children: [
//               Center(
//                 child: Text(
//                   'Deliveries will be done only within Abraka - Delta State',
//                   softWrap: true,
//                   style: Styles.bodyText1,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Form(
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       keyboardType: TextInputType.number,
//                       controller: phoneNumberCont,
//                       maxLength: 11,
//                       style: Styles.bodyText2,
//                       decoration: const InputDecoration(
//                         hintText: 'Phone number: 08100000000',
//                       ),
//                       validator: (value) {
//                         if (value.length < 11) {
//                           return 'Must be a complete phone number';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 15),
//                     TextFormField(
//                       controller: addressCont,
//                       maxLines: 10,
//                       minLines: 4,
//                       maxLength: 100,
//                       style: Styles.bodyText2,
//                       decoration: const InputDecoration(
//                         hintText: 'Hostel/Lodge address...',
//                       ),
//                       validator: (value) {
//                         if (value.length > 100) {
//                           return 'Address too long';
//                         } else if (value.length < 7) {
//                           return "Please type an address";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 10),
//               MyWidgets.raisedButton(
//                 title: "PAY",
//                 onPressed: () {
//                   // if (formKey.currentState.validate()) {
//                   // formKey.currentState.save();
//                   // print("Tel-Aviv : ${MyGlobals.firebaseCurrentUser.uid}");
//                   orderController
//                       .addAnOrder(
//                     oProd: orderedProductList,
//                     totalAmount: total,
//                     productIDList: productIDList,
//                     phoneNumber: phoneNumberCont.text.trim(),
//                     address: addressCont.text.trim(),
//                   )
//                       .then((value) {
//                     phoneNumberCont.clear();
//                     addressCont.clear();
//                   });

//                   // paymentController.payAndUpload(
//                   //   context,
//                   //   purpose: "Product",
//                   //   price: total,
//                   //   successCallback: () {
//                   //     orderController.addAnOrder(
//                   //       totalAmount: total,
//                   //       productIDList: productIDList,
//                   //       phoneNumber: phoneNumberCont.text.trim(),
//                   //       address: addressCont.text.trim(),
//                   //     );
//                   //   },
//                   // );
//                   // }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
