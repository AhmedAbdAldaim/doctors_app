import 'package:doctorapp/screens/doctors/cubit/doctors_cubit.dart';
import 'package:doctorapp/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:doctorapp/screens/intro/cubit/intro_cubit.dart';
import 'package:doctorapp/screens/layout/cubit/layout_cubit.dart';
import 'package:doctorapp/screens/login/cubit/login_cubit.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_cubit.dart';
import 'package:doctorapp/screens/register/cubit/register_cubit.dart';
import 'package:doctorapp/screens/selecte_language/cubit/select_language_cubit.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_cubit.dart';
import 'package:doctorapp/screens/splash_screen.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_helper.dart';
import 'package:doctorapp/shared/observer.dart';
import 'package:doctorapp/shared/style/theme.dart';
import 'package:doctorapp/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await HiveHelper.initsHive();
      await HiveHelper.creatBox();
      await EasyLocalization.ensureInitialized();
      DioHelper.initilazitonDioHelper();
      await SharedPrefrenceseHelper.initsSharedPredfrencese();
      runApp(EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale('en'), Locale('ar')],
          fallbackLocale: const Locale('ar'),
          assetLoader: const CodegenLoader(),
          child: MyApp()));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  String? getlang = SharedPrefrenceseHelper.getData(key: 'lang');
  @override
  Widget build(BuildContext context) {
    //print(getlang);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => IntroCubit()),
        BlocProvider(create: (context) => SelectlanguageCubit()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => MedicalcentersCubit()),
        BlocProvider(create: (context) => SpecialtiesCubit()),
        BlocProvider(create: (context) => DoctorsCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: themeLight,
          home: SplashScreen()),
    );
  }
}
