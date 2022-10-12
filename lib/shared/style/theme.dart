import 'package:doctorapp/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeLight = ThemeData(
    fontFamily: 'ar_font',
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.Mycolor,
    dialogTheme:
        const DialogTheme(titleTextStyle: TextStyle(fontFamily: 'ar_font')),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontFamily: 'ar_font', color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark)));

ThemeData themeDark = ThemeData(
    fontFamily: 'ar_font',
    scaffoldBackgroundColor: HexColor('#333739'),
    primarySwatch: Colors.Mycolor,
    dialogTheme:  const DialogTheme(titleTextStyle: TextStyle(fontFamily: 'ar_font')),
    unselectedWidgetColor: HexColor('#333739'),
    appBarTheme: AppBarTheme(
        backgroundColor: HexColor('#333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(fontFamily: 'ar_font', color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark)));
