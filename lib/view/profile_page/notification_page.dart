import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bioplus/controller/user_controller.dart';
import 'package:bioplus/core/db.dart';
import 'package:bioplus/core/styles.dart';

class NotificationPage extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Styles.headlineText1,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: DB.notificationList(_userController.user.uid),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'You have no notification',
                style: Styles.bodyText2,
              ),
            );
          } else {
            final Notification noti = Notification.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return ListView.builder(
              itemCount: noti.messages!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    noti.messages![index],
                    style: Styles.bodyText2,
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

class Notification {
  String? title;
  List<String>? messages;

  Notification({
    this.title,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': messages,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> doc) {
    // if (doc == null) return null;

    return Notification(
      title: doc['title'].toString(),
      messages: List.from(doc['message'] as Iterable<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());
}
