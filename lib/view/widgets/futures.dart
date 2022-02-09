import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
// import 'package:bioplus/view/dashboard/total_daily/tds.dart';
import 'package:bioplus/view/expenses/expenses.dart';

Widget productCount() {
  return FutureBuilder<QuerySnapshot>(
    future: MyGlobals.productsCollection.get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Text(
          "Product Count ....",
          style: Styles.headlineText1,
        );
      } else {
        return Text(
          "Product Count: ${snapshot.data!.docs.length}",
          style: Styles.headlineText1,
        );
      }
    },
  );
}

Widget getProductAppBarTitle() {
  return FutureBuilder<QuerySnapshot>(
    future: MyGlobals.productsCollection.orderBy("brandName").get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Text(
          "Product Count ....",
          style: Styles.headlineText3,
        );
      } else {
        return Text(
          "Product Count: ${snapshot.data!.docs.length}",
          style: Styles.headlineText3,
        );
      }
    },
  );
}

// Widget getTotalSales() {
//   return FutureBuilder<QuerySnapshot>(
//     future: MyGlobals.dailySalesNoteCollection
//         .orderBy("time", descending: true)
//         .get(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (!snapshot.hasData) {
//         return Text(
//           "Total Sales: ...",
//           style: Styles.headlineText2,
//         );
//       } else {
//         int total = 0;
//         snapshot.data!.docs.forEach((d) {
//           final TotalDailySales totalDailySales =
//               TotalDailySales.fromMap(d.data() as Map<String, dynamic>);
//           total = totalDailySales.amount + total;
//         });

//         return Text(
//           "Total Sales: ${MyGlobals.moneyFormater(total)}",
//           style: Styles.headlineText1,
//         );
//       }
//     },
//   );
// }

Widget getTotalExpenses({required String state}) {
  return FutureBuilder<QuerySnapshot>(
    future: MyGlobals.expensesCollection
        .orderBy(
          "time",
          descending: true,
        )
        .get(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) {
        return Text(
          "Total Debit: ...",
          style: Styles.headlineText1,
        );
      } else {
        int total = 0;
        int totalTransfer = 0;
        int totalDeposit = 0;
        int totalCashSpent = 0;
        // int totalTransfer = 0;
        snapshot.data!.docs.forEach((d) {
          final Expenses e = Expenses.fromMap(d.data() as Map<String, dynamic>);
          total = e.amount + total;
          if (e.isDeposit) {
            totalDeposit = e.amount + total;
          } else if (e.isTransfer) {
            totalTransfer = e.amount + total;
          } else if (e.isCashSpent) {
            totalCashSpent = e.amount + total;
          }
        });
        if (state == "DEBIT") {
          return Text(
            "Total Debit: ${MyGlobals.moneyFormater(total)}",
            style: Styles.headlineText1,
          );
        } else if (state == "TRANSFER") {
          return Text(
            "Total Transfer: ${MyGlobals.moneyFormater(totalTransfer)}",
            style: Styles.headlineText1,
          );
        } else if (state == "DEPOSIT") {
          return Text(
            "Total Deposit: ${MyGlobals.moneyFormater(totalDeposit)}",
            style: Styles.headlineText1,
          );
        } else if (state == "SPENT") {
          return Text(
            "Cash Spent: ${MyGlobals.moneyFormater(totalCashSpent)}",
            style: Styles.headlineText1,
          );
        } else {
          return Text(
            "Total Debit: ${MyGlobals.moneyFormater(total)}",
            style: Styles.headlineText1,
          );
        }
      }
    },
  );
}
