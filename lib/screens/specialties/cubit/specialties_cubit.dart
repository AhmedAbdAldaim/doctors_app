import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/model/specialties_model.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialtiesCubit extends Cubit<SpecialtiesStates> {
  SpecialtiesCubit() : super(InitState());
  static SpecialtiesCubit get(context) => BlocProvider.of(context);

  //connect
  late ConnectivityResult connectivityResult;

  //get Specialites
  SpecialtiesModel? specialtiesModel;
  getSpecialtiesFun(context) async {
    if (HiveHelper.get(key: 'specialties') != null) {
      specialtiesModel =
          SpecialtiesModel.fromJson(HiveHelper.get(key: 'specialties'));
    } else {
      connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        emit(GetSpecialtiesLoadingState());
        DioHelper.getData(
                path: specialties,
                token: SharedPrefrenceseHelper.getData(key: 'token').toString())
            .then((value) {
          specialtiesModel = SpecialtiesModel.fromJson(value.data);
          HiveHelper.add(key: 'specialties', values: value.data).then((value) {
            print(HiveHelper.get(key: 'specialties'));
          });
          print(value.data);
          emit(GetSpecialtiesSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(GetSpecialtiesErrosState());
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
  refreshIndecatortSpecialtiesFun(context) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      onRefresh = true;
      emit(GetSpecialtiesLoadingState());
      DioHelper.getData(
              path: specialties,
              token: SharedPrefrenceseHelper.getData(key: 'token').toString())
          .then((value) async {
        onRefresh = false;
        specialtiesModel = SpecialtiesModel.fromJson(value.data);
        HiveHelper.add(key: 'specialties', values: value.data).then((value) {
          print(HiveHelper.get(key: 'specialties'));
        });
        emit(GetSpecialtiesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSpecialtiesErrosState());
      });
    } else {
      defaultSnakbar(
          content: 'الرجاء التحقق من الإتصال بالإنترنت!',
          color: Colors.red,
          context: context);
    }
  }

  //update When Open Pagee from Internet
  updateWhenOpenPagetSpecialtiesFun(context) async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      DioHelper.getData(
              path: specialties,
              token: SharedPrefrenceseHelper.getData(key: 'token').toString())
          .then((value) async {
        //await HiveHelper.box.clear();
        onRefresh = false;
        specialtiesModel = SpecialtiesModel.fromJson(value.data);
        HiveHelper.add(key: 'specialties', values: value.data).then((value) {
          //  print(HiveHelper.get(key: 'medicalcenters'));
        });
        emit(GetSpecialtiesSuccessState());
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

  //search
  searchSpecialties(val) {
    specialtiesModel!.specialtiesList!.filter =
        specialtiesModel!.specialtiesList!.listspecialties.where((element) {
      return element.specialtiename.contains(val.toString());
    }).toList();
    emit(GetSpecialtiesSuccessState());
  }
}
