import 'package:bioplus/core/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading {
  static Widget spinKitThreeBounce({Color? color}) => Center(
        child: SpinKitRipple(color: color ?? Styles.primaryColor),
        // child: SpinKitRipple,
      );

  static Widget spinKitFadingCircle({Color? color}) => Center(
        child: SpinKitRipple(color: color ?? Styles.primaryColor),
      );
}
