import 'package:doctorapp/main.dart';
import 'package:doctorapp/screens/home_screen.dart';
import 'package:doctorapp/screens/layout/cubit/layout_states.dart';
import 'package:doctorapp/screens/profile_screen.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> screen = const [HomeScreen(), ProfileScreen()];

  bool isar = true;

  getcurrentlang(context) {
    if (SharedPrefrenceseHelper.getData(key: 'lang') != null &&
        SharedPrefrenceseHelper.getData(key: 'lang') == 'ar') {
      isar = true;
    } else if (SharedPrefrenceseHelper.getData(key: 'lang') != null &&
        SharedPrefrenceseHelper.getData(key: 'lang') == 'en') {
      isar = false;
    } else if (EasyLocalization.of(context)!.currentLocale!.languageCode ==
        'ar') {
      isar = true;
    } else {
      isar = false;
    }
  }

  chabgeBottomNavBar(int val) {
    index = val;
    emit(ChangeBottomNavBarStates());
  }

  changeLanguageAr() {
    isar = true;
    emit(ChangeLanguageArStates());
  }

  changeLanguageEn() {
    isar = false;
    emit(ChangeLanguageEnStates());
  }

  saveLange(BuildContext context) async {
    if (isar == true) {
      await context.setLocale(Locale('ar'));
      SharedPrefrenceseHelper.setData(key: 'lang', value: 'ar');
      emit(ChangeLanguageArStates());
    } else {
      await context.setLocale(Locale('en'));
      SharedPrefrenceseHelper.setData(key: 'lang', value: 'en');
      emit(ChangeLanguageEnStates());
    }
  }
}
