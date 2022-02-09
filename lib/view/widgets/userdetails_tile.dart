import 'package:bioplus/core/app_users.dart';
import 'package:bioplus/core/styles.dart';
import 'package:bioplus/view/widgets/user_popup_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bioplus/view/widgets/widgets.dart';

Widget getUserInfo({
  required AppUser author,
  required String timePosted,
}) {
  return SizedBox(
    height: 50,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            MyWidgets.dialog(AddTodoPopupCard(user: author));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 30,
                width: 30,
                child: CachedNetworkImage(
                  imageUrl: author.profilePic,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Container(),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              author.username,
              style: author.adminTypes.contains("News")
                  ? Styles.subtitle1
                  : Styles.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: author.adminTypes.contains("News")
                      ? Colors.green
                      : Styles.canvasColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

CircleAvatar getCircleAvatar(AppUser author) => CircleAvatar(
      radius: 20.0,
      backgroundImage: NetworkImage(author.profilePic),
      backgroundColor: Colors.transparent,
    );
