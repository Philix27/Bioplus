import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subtitle;
  final void Function() onTap;
  // final Widget subtitle;

  const CustomListTile({
    required this.icon,
    required this.text,
    this.subtitle,
    required this.onTap,
    // this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    bool hasSubtitle = false;
    if (subtitle != null) {
      hasSubtitle = true;
    }
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Styles.canvasColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Styles.primaryColor,
                  ),
                  const SizedBox(width: 15.0),
                  Column(
                    children: [
                      Text(
                        text,
                        style: Styles.headlineText2,
                      ),
                      if (hasSubtitle)
                        Column(
                          children: [
                            const SizedBox(height: 15.0),
                            Text(
                              subtitle!,
                              style: Styles.headlineText2,
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  ),

                  // subtitle
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget questionListTile({
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  required bool isCompleted,
}) {
  return Card(
    color: Styles.canvasColor,
    child: ListTile(
      onTap: onTap,
      tileColor: Styles.canvasColor,
      horizontalTitleGap: 8,
      minLeadingWidth: 20,
      title: Text(
        title,
        style: Styles.headlineText2,
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Styles.headlineText2!.copyWith(fontSize: 10),
      ),
      leading: Icon(
        Icons.circle,
        color: isCompleted ? Colors.green : Styles.backgroundColor,
      ),
    ),
  );
}
