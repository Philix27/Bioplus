import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioplus/view/widgets/loading.dart';

class RegisterPage extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icon/lu.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black38,
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          style: Styles.bodyText2,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _password,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: Styles.bodyText2,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else if (value.length < 8) {
                              return 'Please enter more than 8 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _phoneNumber,
                          keyboardType: TextInputType.number,
                          style: Styles.bodyText2,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.all(20),
                            hintText: 'Phone number e.g 0810000000',
                          ),
                           validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter phone number';
                            } else if (value.length < 11) {
                              return 'Please enter more than 8 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Obx(() {
                  return Get.find<AuthController>().isSigningIn.value
                      ? Loading.spinKitThreeBounce(color: Colors.white)
                      : RaisedButton(
                          onPressed: () {
                            controller.login();
                          },
                          color: Colors.white,
                          textColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                color: Styles.color,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
