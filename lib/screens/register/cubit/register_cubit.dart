import 'package:doctorapp/model/user_model.dart';
import 'package:doctorapp/screens/register/cubit/register_states.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  // Show Passowrd or Visibilty
  bool isPassword = true;
  changeVisibiltPassword() {
    isPassword = !isPassword;
    emit(ChangevisibilitPasswordState());
  }

  bool isPasswordconfirmation = true;
  changeVisibiltPasswordconfirmation() {
    isPasswordconfirmation = !isPasswordconfirmation;
    emit(ChangevisibilitPasswordConfiremState());
  }

  //Register
  UserModel? usermodel;
  registerFun(
      {required String name,
      required String email,
      required String password,
      required String passwordconfirmation}) {
    emit(RegisterLoadingState());
    DioHelper.postData(path: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordconfirmation
    }).then((value) {
      usermodel = UserModel.fromJson(value.data);
      print(value.data);
      print(value.statusCode.toString());
      emit(RegisterSuccesstState(usermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  resetController(
      TextEditingController firstname,
      TextEditingController lastname,
      TextEditingController email,
      TextEditingController password,
      TextEditingController passwordconfirm) {
    firstname.clear();
    lastname.clear();
    email.clear();
    password.clear();
    passwordconfirm.clear();
  }
}
