import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:timeago/timeago.dart';

class Expenses {
  final String time;
  final String docID;
  final String description;
  final Timestamp dateTime;
  final int amount;
  final bool isDeposit;
  final bool isTransfer;
  final bool isCashSpent;
  Expenses({
    required this.isDeposit,
    required this.isTransfer,
    required this.isCashSpent,
    required this.dateTime,
    required this.description,
    required this.amount,
    required this.docID,
    required this.time,
  });

  factory Expenses.fromMap(Map<String, dynamic> map) {
    final tempTime = map['time'] as Timestamp;
    final String time = format(tempTime.toDate()).toString();

    return Expenses(
      time: time,
      dateTime: tempTime,
      description: map['description'].toString(),
      docID: map['docID'].toString(),
      amount: int.parse(map['amount'].toString()),
      isCashSpent: map['isCashSpent'] as bool,
      isDeposit: map['isDeposit'] as bool,
      isTransfer: map['isTransfer'] as bool,
    );
  }

  static Future<void> updateExpense(String id) async =>
      MyGlobals.expensesCollection.doc(id).update({
        "isCashSpent": false,
        "isDeposit": false,
        "isTransfer": false,
      }).then((value) => MyWidgets.toast("Updated"));
}
