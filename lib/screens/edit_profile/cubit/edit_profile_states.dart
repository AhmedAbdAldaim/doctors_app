import 'package:doctorapp/model/user_model.dart';

abstract class EditProfileStates {}

class InitState extends EditProfileStates {}

class ChangevisibilitoldPasswordState extends EditProfileStates {}

class ChangevisibilitnewPasswordState extends EditProfileStates {}

class EditProfileLoadingState extends EditProfileStates {}

class EditProfileSuccesstState extends EditProfileStates {
  final UserModel usermodel;
  EditProfileSuccesstState(this.usermodel);
}

class EditProfileErrorState extends EditProfileStates {
  final String error;
  EditProfileErrorState(this.error);
}

class SelectedImageSuccess extends EditProfileStates{}
