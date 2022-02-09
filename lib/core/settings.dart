// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// class Setting {
//   final Timestamp expiryDate;
//   final int limitCount;
//   final int advertCount;
//   final bool showShop;
//   final bool showNewsUpload;
//   final bool showGroupChats;
//   final List<String> releaseList;

//   Setting({
//     this.expiryDate,
//     this.limitCount,
//     required this.advertCount,
//     required this.showShop,
//     this.releaseList,
//     required this.showNewsUpload,
//     required this.showGroupChats,
//   });

//   factory Setting.fromDocumentsnapshot(DocumentSnapshot doc) {
//     return Setting(
//       // expiryDate: doc.data()['expirationDate'] as Timestamp,
//       // limitCount: int.parse(doc.data()['limitCount'].toString()),
//       showShop: doc.data()['showShop'] as bool,
//       showNewsUpload: doc.data()['showNewsUpload'] as bool,
//       showGroupChats: doc.data()['showGroupChats'] as bool,
//       advertCount: int.parse(doc.data()['advertCount'].toString()),
//       // releaseList: List.from(doc.data()['releaseList'] as Iterable<dynamic>),
//     );
//   }
// }
