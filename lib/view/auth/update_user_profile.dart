import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/home/home.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:bioplus/view/widgets/widgets.dart';

class UpdateUserPage extends StatefulWidget {
  final bool isFromAuth;
  const UpdateUserPage({Key? key, this.isFromAuth = false}) : super(key: key);

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final UserController _userController = Get.put(UserController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  List<Asset> _images = [];
  bool isUploadingImage = false;
  bool isUploadingUsername = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Setup Profile', style: Styles.headlineText1),
              automaticallyImplyLeading: false,
              backgroundColor: Styles.canvasColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: Image.asset(
                        "assets/images/profile.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
          color: Styles.backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ListView(
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_a_photo,
                  color: Styles.primaryColor,
                ),
                onPressed: loadAssets,
              ),
              const SizedBox(height: 20),
              Center(
                child: isUploadingImage
                    ? Loading.spinKitThreeBounce()
                    : MyWidgets.raisedButton(
                        title: 'Upload profile image',
                        onPressed: () {
                          if (_images.isNotEmpty) {
                            // _userController.updatePPic(
                            //   MyGlobals.firebaseCurrentUser.uid,
                            //   _images,
                            // );

                            setState(() {
                              isUploadingImage = true;
                            });
                          } else {
                            MyWidgets.errorSnackbar('Select a profile picture');
                          }
                        },
                      ),
              ),
              const SizedBox(height: 30),
              Divider(color: Styles.primaryColor),
              const SizedBox(height: 30),
              // if (Get.find<UserController>().user.phoneNumber.isEmpty)
              Column(
                children: [
                  Text(
                    'Kindly setup your phone number (especially) and username to avoid restrictions',
                    style: Styles.headlineText2,
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          autocorrect: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          style: Styles.bodyText2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Username',
                            hintStyle: Styles.bodyText2,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _phoneNumberController,
                          autocorrect: false,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 11) {
                              return 'Must be 11 characters';
                            }
                            return null;
                          },
                          style: Styles.bodyText2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Phone number',
                            hintStyle: Styles.bodyText2,
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: isUploadingUsername
                              ? Loading.spinKitThreeBounce()
                              : MyWidgets.raisedButton(
                                  title: 'Update',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      _userController.updateUserPhoneNumber(
                                        uid: MyGlobals.firebaseCurrentUser.uid,
                                        username: _usernameController
                                            .text.capitalizeFirst!
                                            .trim(),
                                        phoneNumber:
                                            _phoneNumberController.text.trim(),
                                      );
                                      setState(() {
                                        isUploadingUsername = true;
                                      });
                                      // if (widget.isFromAuth) {
                                      //   Get.off(const HomePage());
                                      // }
                                    }
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#1976D2",
          statusBarColor: '#1976D2',
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#1976D2",
        ),
      );
    } on Exception catch (e) {
      MyWidgets.errorSnackbar(e);
    }

    setState(() {
      _images = resultList;
    });
  }
}
