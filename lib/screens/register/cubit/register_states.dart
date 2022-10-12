import 'package:doctorapp/model/user_model.dart';

abstract class RegisterStates {}

class InitState extends RegisterStates {}

class ChangevisibilitPasswordState extends RegisterStates {}

class ChangevisibilitPasswordConfiremState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccesstState extends RegisterStates {
  final UserModel usermodel;
  RegisterSuccesstState(this.usermodel);
}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
