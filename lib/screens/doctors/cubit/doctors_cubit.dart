import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/model/doctors_model.dart';
import 'package:doctorapp/screens/doctors/cubit/doctors_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsCubit extends Cubit<DoctorsStates> {
  DoctorsCubit() : super(InitState());
  static DoctorsCubit get(context) => BlocProvider.of(context);

  //connect
  late ConnectivityResult connectivityResult;

  DoctorsModel? doctorsModel;
  getDoctorsFun({ context ,required int medicalCenterID, required int specialteID}) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      emit(GetDoctorsLoadingState());
      DioHelper.postData(
              path: doctors,
              data: {
                'medical_center_id': medicalCenterID,
                'specialtie_id': specialteID
              },
              token: SharedPrefrenceseHelper.getData(key: 'token').toString())
          .then((value) {
        doctorsModel = DoctorsModel.fromJson(value.data);
        print(value.data);
        emit(GetDoctorsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetDoctorsErrosState());
      });
    } else {
      defaultSnakbar(
          content: 'الرجاء التحقق من الإتصال بالإنترنت!',
          color: Colors.red,
          context: context);
    }
  }

  searchDoctor(val) {
    doctorsModel!.doctorsList!.filter =
        doctorsModel!.doctorsList!.listDoctor.where((element) {
      return element.name.contains(val.toString());
    }).toList();
    emit(GetDoctorsSuccessState());
  }
}
