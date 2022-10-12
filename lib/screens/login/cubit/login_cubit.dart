import 'package:doctorapp/model/user_model.dart';
import 'package:doctorapp/screens/login/cubit/login_states.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitState());
  static LoginCubit get(context) => BlocProvider.of(context);

  // Show Passowrd or Visibilty
  bool isPassword = true;
  changeVisibiltPassword() {
    isPassword = !isPassword;
    emit(ChangevisibilitState());
  }

  //login
  UserModel? usermodel;

  loginFun({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        path: login,
        data: {'email': email, 'password': password}).then((value) {
      usermodel = UserModel.fromJson(value.data);
      print(value.data);

      emit(LoginSuccesstState(usermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  resetController(
    TextEditingController email,
    TextEditingController password,
  ) {
    email.clear();
    password.clear();
  }
}
