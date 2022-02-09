import 'package:bioplus/controller/uploader_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final Uploader _uploader = Get.put(Uploader());

  Rx<bool> _isPaymentSuccessful = Rx(false);
  Rx<bool> get isPaymentSuccessful => _isPaymentSuccessful;

  final Map<String, dynamic> paymentDetails = {
    'userName': MyGlobals.firebaseCurrentUser.displayName,
    'userID': MyGlobals.firebaseCurrentUser.uid,
    'email': MyGlobals.firebaseCurrentUser.email,
    'phoneNumber': MyGlobals.firebaseCurrentUser.phoneNumber,
  };

  Future<void> payAndUpload(
    BuildContext context, {
    required VoidCallback successCallback,
    required String purpose,
    required int price,
    required PaystackPlugin plugin,
  }) async {
    paymentDetails.addAll({
      'paymentPurpose': purpose,
      'amountToPay': price,
    });

    final Charge charge = Charge()
      ..amount = int.parse("${price}00")
      ..email = MyGlobals.firebaseCurrentUser.email
      ..putMetaData(MyGlobals.firebaseCurrentUser.uid, paymentDetails)
      ..reference = DateTime.now().toString();

    final CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    //? On successfuk Payment
    if (response.status) {
      _isPaymentSuccessful.value = true;
      successCallback();
    } else {
      _isPaymentSuccessful.value = false;
      MyWidgets.snackbar(
        title: 'Failed',
        message: 'Payment not successful',
        bgColor: Styles.warningColor,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    _isPaymentSuccessful = Rx(false);
  }
}
