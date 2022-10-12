import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctorapp/screens/home_screen.dart';
import 'package:doctorapp/screens/layout/layout_screen.dart';
import 'package:doctorapp/screens/login/cubit/login_cubit.dart';
import 'package:doctorapp/screens/login/cubit/login_states.dart';
import 'package:doctorapp/screens/register/register_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          context.loaderOverlay.hide();
          alertDialog(
              context: context,
              title: LocaleKeys.error.tr(),
              content: LocaleKeys.error_msg_login.tr());
        }
        if (state is LoginSuccesstState) {
          SharedPrefrenceseHelper.setData(
                  key: 'token', value: 'Bearer ${state.usermodel.token}')
              .then((value) {
            if (value) {
              SharedPrefrenceseHelper.setData(
                  key: 'name', value: state.usermodel.userData!.name);
              SharedPrefrenceseHelper.setData(
                  key: 'email', value: state.usermodel.userData!.email);
              SharedPrefrenceseHelper.setData(
                  key: 'password', value: password.text);
              context.loaderOverlay.hide();
              LoginCubit.get(context).resetController(email, password);
              navigatepushAndRemoveUntil(context, const LayoutScreen());
            }
          });
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return LoaderOverlay(
          useDefaultLoading: true,
          overlayColor: Colors.black,
          overlayOpacity: 0.3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.email.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    )),
                            defaultTextFormFaild(
                                controller: email,
                                type: TextInputType.emailAddress,
                                action: TextInputAction.next,
                                valid: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.valid_email.tr();
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)) {
                                    return LocaleKeys.check_email.tr();
                                  }
                                  return null;
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.password.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    )),
                            defaultTextFormFaild(
                                controller: password,
                                type: TextInputType.text,
                                action: TextInputAction.done,
                                valid: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.valid_password.tr();
                                  }
                                  return null;
                                },
                                ispassword: cubit.isPassword,
                                suffixicon: cubit.isPassword
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.grey,
                                      )
                                    : const Icon(Icons.visibility_off_outlined,
                                        color: Colors.grey),
                                changepassword: () {
                                  cubit.changeVisibiltPassword();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.Mycolor,
                          ),
                          child: defaultButton(
                              color: Colors.white,
                              onPressed: () async {
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult ==
                                        ConnectivityResult.mobile ||
                                    connectivityResult ==
                                        ConnectivityResult.wifi) {
                                  if (formkey.currentState!.validate()) {
                                    //LOADING
                                    context.loaderOverlay.show();
                                    cubit.loginFun(
                                        email: email.text,
                                        password: password.text);
                                  }
                                } else {
                                  defaultSnakbar(
                                      content: LocaleKeys.check_internt.tr(),
                                      color: Colors.red,
                                      context: context);
                                }
                              },
                              title: LocaleKeys.login.tr()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.Mycolor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: defaultButton(
                                color: Colors.Mycolor,
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                title: LocaleKeys.create_accont.tr())),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
