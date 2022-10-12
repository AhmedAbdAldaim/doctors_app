import 'package:doctorapp/screens/selecte_language/cubit/select_language_states.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectlanguageCubit extends Cubit<SelectlanguageStates> {
  SelectlanguageCubit() : super(InitSelectlanguageState());

  static SelectlanguageCubit get(context) => BlocProvider.of(context);

  bool isar = true;
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
