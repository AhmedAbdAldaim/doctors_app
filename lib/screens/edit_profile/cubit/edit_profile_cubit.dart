import 'dart:io';
import 'package:doctorapp/model/user_model.dart';
import 'package:doctorapp/screens/edit_profile/cubit/edit_profile_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(InitState());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  // Show oldPassowrd or Visibilty
  bool isOldPassword = true;
  changeVisibiltOldPassword() {
    isOldPassword = !isOldPassword;
    emit(ChangevisibilitoldPasswordState());
  }

  bool isNewPassword = true;
  changeVisibiltNewPassword() {
    isNewPassword = !isNewPassword;
    emit(ChangevisibilitnewPasswordState());
  }

  //EditProfile
  UserModel? usermodel;
  editProfileFun(
      {required String name, required String email, String? newpassword}) {
    emit(EditProfileLoadingState());
    DioHelper.postData(
            token: SharedPrefrenceseHelper.getData(key: 'token').toString(),
            path: editprofile,
            data: {'name': name, 'email': email, 'password': newpassword})
        .then((value) {
      usermodel = UserModel.fromJson(value.data);
      emit(EditProfileSuccesstState(usermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(EditProfileErrorState(error.toString()));
    });
  }

  File? profileFile;
  ImagePicker picker = ImagePicker();

  resetFile() {
    profileFile = null;
  }

  selectedImage(int type) async {
    if (type == 1) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.camera].request();
      if (statuses[Permission.camera]!.isGranted) {
        final pic = await picker.pickImage(source: ImageSource.camera);
        if (pic != null) {
          profileFile = File(pic.path);
          emit(SelectedImageSuccess());
        } else {
          print('not selected!');
        }
      } else if (statuses[Permission.camera]!.isPermanentlyDenied) {
        defautToast(message: 'قم بتفعيل اذن التطبيق ', state: StateToast.WRANG);
        openAppSettings();
      }
    } else if (type == 2) {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.storage].request();
      if (statuses[Permission.storage]!.isGranted) {
        final pic = await picker.pickImage(source: ImageSource.gallery);
        if (pic != null) {
          profileFile = File(pic.path);
          emit(SelectedImageSuccess());
        } else {
          print('not selected!');
        }
      } else if (statuses[Permission.storage]!.isPermanentlyDenied) {
        defautToast(message: 'قم بتفعيل اذن التطبيق ', state: StateToast.WRANG);
        openAppSettings();
      }
    }
  }

  // Future UplodeImage() async {
  //   if (file == null) return;
  //   String beas464 = base64Encode(file!.readAsBytesSync());
  //   String nameimage = file!.path.split('/').last;
  //   var url = Uri.parse("http://192.168.43.176/mobiles/uplodeimg.php");
  //   var res =  await http.post(url, body: {'imagebase': beas464, 'imagename': nameimage});

  // }
}
