import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/expenses/add_expenses.dart';
import 'package:bioplus/view/expenses/expenses.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class ExpensesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses Made',
          style: Styles.headlineText4,
        ),
        centerTitle: true,
      ),
      floatingActionButton: MyWidgets.fab(
          icon: Icons.add,
          onTap: () {
            MyWidgets.goTo(AddExpenses());
          }),
      body: FutureBuilder<QuerySnapshot>(
        future: MyGlobals.expensesCollection
            .orderBy("time", descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading.spinKitThreeBounce();
          } else if (snapshot.data!.docs.isEmpty) {
            return Container();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final DocumentSnapshot postDoc = snapshot.data!.docs[index];

                final Expenses expenses = Expenses.fromMap(postDoc.data()  as Map<String , dynamic>);
                if (expenses.isCashSpent == null) {
                  Expenses.updateExpense(expenses.docID);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 6,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}.",
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: Styles.bodyText2,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          expenses.description,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: Styles.bodyText2,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            expenses.time,
                                            style: Styles.bodyText2!
                                                .copyWith(fontSize: 12),
                                          ),
                                          Text(
                                            MyGlobals
                                                .timestampDateStringFormatter(
                                                    expenses.dateTime),
                                            style: Styles.bodyText2!
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        MyGlobals.moneyFormater(
                                            expenses.amount),
                                        style: Styles.headlineText2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: Container(color: Colors.green)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
