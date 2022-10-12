import 'package:doctorapp/screens/login/login_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

logout(context) {
  SharedPrefrenceseHelper.remove(key: 'token').then((value) {
    SharedPrefrenceseHelper.remove(key: 'name');
    SharedPrefrenceseHelper.remove(key: 'email');
    navigatepushAndRemoveUntil(context, LoginScreen());
  });
}

getCurrentLang(){
 return SharedPrefrenceseHelper.getData(key: 'lang');
}
