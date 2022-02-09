import 'package:cached_network_image/cached_network_image.dart';
import 'package:bioplus/controller/all_bindings.dart';
import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/core/global_variables.dart';
import 'package:bioplus/core/styles.dart';
// import 'package:bioplus/core/theme_services.dart';
import 'package:bioplus/view/auth/update_user_profile.dart';
import 'package:bioplus/view/profile_page/notification_page.dart';
import 'package:bioplus/view/widgets/custom_list_tile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:bioplus/view/widgets/widgets.dart';
import 'package:get/get.dart';

part 'suggestion_page.dart';
part 'profile_body.dart';
part 'profile_popup.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: Styles.headlineText3),
        elevation: 0.0,
        actions: [
          PopupMenuButton(
            onSelected: ProfilePopup.choiceAction,
            icon: Icon(
              Icons.more_vert_rounded,
              color: Styles.primaryColor,
            ),
            color: Styles.canvasColor,
            itemBuilder: (BuildContext context) {
              return ProfilePopup.choices
                  .map(
                    (String choice) => PopupMenuItem(
                      value: choice,
                      child: Text(
                        choice,
                        style: Styles.headlineText2,
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }
}
