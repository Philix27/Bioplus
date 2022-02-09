import 'package:bioplus/core/app_users.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddTodoPopupCard extends StatelessWidget {
  const AddTodoPopupCard({
    Key? key,
    required this.user,
  }) : super(key: key);
  final AppUser user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),

        child: Material(
          color: Styles.canvasColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120.0,
                    width: 120.0,
                    child: Card(
                      color: Styles.backgroundColor,
                      child: CachedNetworkImage(
                        imageUrl: user.profilePic,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Loading.spinKitThreeBounce(),
                        errorWidget: (context, url, error) =>
                            Loading.spinKitThreeBounce(
                                color: Styles.warningColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Styles.backgroundColor,
                    child: ListTile(
                      title: Text(
                        user.username,
                        style: Styles.subtitle1,
                      ),
                    ),
                  ),
                  Card(
                    color: Styles.backgroundColor,
                    child: ListTile(
                      title: Text(
                        user.email,
                        style: Styles.subtitle1,
                      ),
                    ),
                  ),
                  Card(
                    color: Styles.backgroundColor,
                    child: ListTile(
                      title: Text(
                        user.uid,
                        softWrap: true,
                        style: Styles.bodyText2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
