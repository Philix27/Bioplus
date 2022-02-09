import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bioplus/view/widgets/loading.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController controller = AuthController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _productCategoryCode = TextEditingController();

  bool isRegister = false;
  bool passwordLength = false;
  bool hidePassword = true;
  bool addCode = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _phoneNumber.dispose();
  }

  void clearControllers() {
    _email.clear();
    _password.clear();
    _phoneNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.color,
      body: ListView(
        children: [
          const SizedBox(height: 50),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icon/10.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          isRegister ? 'Create Account' : "Login",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      style: Styles.bodyText2,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Styles.color),
                        contentPadding: EdgeInsets.all(20),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _password,
                      maxLength: 11,
                      // keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword,
                      style: Styles.bodyText2,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Styles.color),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color:
                                hidePassword ? Colors.grey[500] : Styles.color,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(20),
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
                    if (isRegister)
                      TextFormField(
                        controller: _phoneNumber,
                        maxLength: 11,
                        keyboardType: TextInputType.number,
                        style: Styles.bodyText2,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Styles.color),
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Contact e.g 0810000000',
                        ),
                        validator: (value) {
                          if (isRegister) {
                            if (value!.isEmpty) {
                              return 'Please enter phone number';
                            } else if (value.length < 11) {
                              return 'Please enter more than 8 characters';
                            }
                            return null;
                          }
                        },
                      ),
                    // const SizedBox(height: 10),
                    if (addCode)
                      TextFormField(
                        controller: _productCategoryCode,
                        style: Styles.bodyText2,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.medical_services,
                            color: Styles.color,
                          ),
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Prescription',
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // const Spacer(),
          const SizedBox(height: 50),
          Obx(() {
            return Get.find<AuthController>().isSigningIn.value
                ? Loading.spinKitThreeBounce(color: Colors.white)
                // ignore: deprecated_member_use
                : Center(
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (isRegister) {
                            controller.registerEmail(
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                              phone: _phoneNumber.text.trim(),
                              displayCode:
                                  _productCategoryCode.text.trim().isEmpty
                                      ? "OTC"
                                      : _productCategoryCode.text.trim(),
                            );
                            // clearControllers();
                          } else {
                            controller.loginEmail(
                              email: _email.text.trim(),
                              password: _password.text.trim(),
                              displayCode:
                                  _productCategoryCode.text.trim().isEmpty
                                      ? "OTC"
                                      : _productCategoryCode.text.trim(),
                            );
                            // clearControllers();
                          }
                        }
                      },
                      color: Colors.white,
                      textColor: Styles.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Styles.color,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
          const SizedBox(height: 30),
          // if(isRegister)
          Center(
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  isRegister = !isRegister;
                });
              },
              color: Colors.white,
              textColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  isRegister ? 'Have an account? Login' : "Create new account",
                  style: const TextStyle(
                    color: Styles.color,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: () {
              setState(() {
                addCode = !addCode;
              });
            },
            child: const Center(
              child: Text(
                "Become VIP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
