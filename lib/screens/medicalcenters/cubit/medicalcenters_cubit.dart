import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/model/medical_center_model.dart';
import 'package:doctorapp/screens/check_internet.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_states.dart';
import 'package:doctorapp/screens/medicalcenters/medicalc_center_screen.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MedicalcentersCubit extends Cubit<MedicalcentersStates> {
  MedicalcentersCubit() : super(InitMedicalState());
  static MedicalcentersCubit get(context) => BlocProvider.of(context);

  //connect
  late ConnectivityResult connectivityResult;
  //get MediaclCenter
  MedicalCenterModel? medicalCenterMode;
  getMedicalcentersFun(context) async {
    if (HiveHelper.get(key: 'medicalcenters') != null) {
      medicalCenterMode =
          MedicalCenterModel.fromJson(HiveHelper.get(key: 'medicalcenters'));
    } else {
      connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        emit(GetMedicalCentersLoadingState());
        DioHelper.getData(
                path: medicalCenters,
                token: SharedPrefrenceseHelper.getData(key: 'token').toString())
            .then((value) {
          medicalCenterMode = MedicalCenterModel.fromJson(value.data);
          HiveHelper.add(key: 'medicalcenters', values: value.data)
              .then((value) {
            print(HiveHelper.get(key: 'medicalcenters'));
          });
          emit(GetMedicalCentersSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(GetMedicalCentersErrosState());
        });
      } else {
        defaultSnakbar(
            content: 'الرجاء التحقق من الإتصال بالإنترنت!',
            color: Colors.red,
            context: context);
      }
    }
  }

  bool onRefresh = false;
  //Refresh Indector from Internet
  refreshIndecatortMedicalcentersFun(context) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      onRefresh = true;
      emit(GetMedicalCentersLoadingState());
      DioHelper.getData(
              path: medicalCenters,
              token: SharedPrefrenceseHelper.getData(key: 'token').toString())
          .then((value) async {
        onRefresh = false;
        medicalCenterMode = MedicalCenterModel.fromJson(value.data);
        HiveHelper.add(key: 'medicalcenters', values: value.data).then((value) {
          print(HiveHelper.get(key: 'medicalcenters'));
        });
        emit(GetMedicalCentersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetMedicalCentersErrosState());
      });
    } else {
      defaultSnakbar(
          content: 'الرجاء التحقق من الإتصال بالإنترنت!',
          color: Colors.red,
          context: context);
    }
  }

  //update When Open Pagee from Internet
  updateWhenOpenPagetMedicalcentersFun(context) async {
     connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      DioHelper.getData(
              path: medicalCenters,
              token: SharedPrefrenceseHelper.getData(key: 'token').toString())
          .then((value) {
        onRefresh = false;
        medicalCenterMode = MedicalCenterModel.fromJson(value.data);
        HiveHelper.add(key: 'medicalcenters', values: value.data).then((value) {
          print(HiveHelper.get(key: 'medicalcenters'));
        });
        emit(GetMedicalCentersSuccessState());
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      defaultSnakbar(
          content: 'الرجاء التحقق من الإتصال بالإنترنت!',
          color: Colors.red,
          context: context);
    }
  }

  //search Medical
  searchMedicalCenter(val) {
    medicalCenterMode!.medicalCenterList!.filter =
        medicalCenterMode!.medicalCenterList!.listataMedical.where((element) {
      return element.name.contains(val.toString()) ||
          element.address.contains(val.toString());
    }).toList();
    emit(GetMedicalCentersSuccessState());
  }

}
