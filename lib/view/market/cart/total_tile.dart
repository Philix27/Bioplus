import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';

Widget totalTile({
  required String leading,
  required String trailing,
  bool makeBold = false,
}) {
  return Wrap(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: makeBold
                ? Styles.headlineText4!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )
                : Styles.headlineText4,
          ),
          Text(
            trailing,
            style: makeBold
                ? Styles.headlineText4!.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  )
                : Styles.headlineText4,
          ),
        ],
      ),
      if (!makeBold)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Divider(
            color: Styles.backgroundColor,
            thickness: 1,
          ),
        ),
    ],
  );
}
