

import 'package:doctorapp/model/user_model.dart';

abstract class LoginStates {}

class InitState extends LoginStates {}

class ChangevisibilitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccesstState extends LoginStates {
   final UserModel usermodel;
  LoginSuccesstState(this.usermodel);
}

class LoginErrorState extends LoginStates {}
