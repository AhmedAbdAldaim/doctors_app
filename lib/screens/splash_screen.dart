import 'dart:async';

import 'package:doctorapp/screens/home_screen.dart';
import 'package:doctorapp/screens/intro/intro_screen.dart';
import 'package:doctorapp/screens/layout/layout_screen.dart';
import 'package:doctorapp/screens/login/login_screen.dart';
import 'package:doctorapp/screens/selecte_language/select_language_screen.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final String? token = SharedPrefrenceseHelper.getData(key: 'token');
  final String? lang = SharedPrefrenceseHelper.getData(key: 'lang');
  final bool? intro = SharedPrefrenceseHelper.getData(key: 'intro');

  Widget page() {
    if (lang != null && intro != null && token != null) {
      return const LayoutScreen();
    } else if (lang != null && intro != null && token == null) {
      return LoginScreen();
    } else if (lang != null) {
      return IntroScreen();
    }
    return const SelectlanguageScreen();
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 7), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (contex) => page()), (route) => false);
    });
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logos.png'),
          Lottie.asset('assets/images/loader.json', height: 80)
        ],
      ),
    ));
  }
}
