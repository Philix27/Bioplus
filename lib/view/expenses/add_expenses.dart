import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class AddExpenses extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expenses',
          style: Styles.headlineText4,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('Description', style: Styles.bodyText2),
                TextFormField(
                  controller: _descriptionController,
                  style: Styles.bodyText2,
                  maxLines: 2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please describe expense';
                    } else if (value.length <= 2) {
                      return 'Please enter more than 2 characters';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: 'Description of expense',
                  ),
                ),
                const SizedBox(height: 30),
                Text('Amount', style: Styles.bodyText2),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: Styles.bodyText2,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    hintText: 'Amount',
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: MyWidgets.raisedButton(
                    title: "Send",
                    onPressed: () {
                      final String docID =
                          Timestamp.now().millisecondsSinceEpoch.toString();
                      addExpense(
                        docID,
                        {
                          "docID": docID,
                          "description": _descriptionController.text.trim(),
                          "amount": _amountController.text.trim(),
                          "time": Timestamp.now(),
                          "isDeposit": false,
                          "isTransfer": false,
                          "isCashSpent": false,
                        },
                      ).then((value) {
                        _amountController.clear();
                        _descriptionController.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> addExpense(String id, Map<String, dynamic> data) async =>
    MyGlobals.expensesCollection
        .doc(id)
        .set(data)
        .then((value) => MyWidgets.toast("Added"));
