import 'package:bioplus/controller/all_bindings.dart';
import 'package:bioplus/core/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:bioplus/core/auth_switch.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Care First',
      initialRoute: "/",
      home: AuthSwitch(),
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      // themeMode: ThemeService().getThemeMode(),
      // themeMode: ThemeMode.system
    );
  }
}
