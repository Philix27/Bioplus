import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bioplus/core/styles.dart';

class CustomTheme {
  final String u = '';
//! Dark Theme
//! Dark Theme
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    //! Input
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      fillColor: Colors.blueGrey[900],
      focusColor: Colors.blueGrey[900],
      isCollapsed: true,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    ),

    //* AppBar

    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[900],
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    ),
    tabBarTheme: const TabBarTheme(labelColor: Colors.white),
    canvasColor: Colors.blueGrey[900],
    primaryColor: Colors.white,
    accentColor: Colors.blue[200],
    scaffoldBackgroundColor: Colors.blueGrey[800],
    backgroundColor: Colors.blueGrey[800],
    iconTheme: const IconThemeData(color: Colors.white),
    buttonColor: Colors.white,
    //Regular TextTheme
    textTheme: TextTheme(
      headline1: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      headline3: TextStyle(
        color: Colors.blueGrey[900],
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        color: Colors.blueGrey[900],
        fontSize: 15,
      ),
      bodyText1: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      bodyText2: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      subtitle1: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      // subtitle1: const TextStyle(color: Colors.blueGrey),
    ),
  );

//! Light Theme
//! Light Theme

  // static ThemeData darkTheme = ThemeData.dark().copyWith(
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.dark,
    // primaryColorLight: Colors.white,
    // primaryColorDark: Styles.color,
    canvasColor: Colors.white,
    primaryColor: Styles.color,
    accentColor: Colors.blue[200],
    scaffoldBackgroundColor: Colors.grey[200],
    backgroundColor: Colors.grey[200],
    iconTheme: const IconThemeData(color: Styles.color),
    buttonColor: Styles.color,
    //! Work on below
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(20),
      fillColor: Colors.white,
      focusColor: Colors.white,
      isCollapsed: true,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    ),

    appBarTheme: const AppBarTheme(
      // color: Colors.white,
      color: Styles.color,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(
        color: Styles.color,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF087040),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Styles.color,
    ),

    //Regular TextTheme
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Styles.color,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        color: Styles.color,
        fontSize: 15,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      bodyText1: TextStyle(
        color: Colors.black87,
        fontSize: 18,
      ),
      bodyText2: TextStyle(
        color: Colors.black54,
        fontSize: 15,
      ),
      subtitle1: TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      subtitle2: TextStyle(
        color: Styles.color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
