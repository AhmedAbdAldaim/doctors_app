import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/screens/layout/layout_screen.dart';
import 'package:doctorapp/screens/register/cubit/register_cubit.dart';
import 'package:doctorapp/screens/register/cubit/register_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final passwordconfirmation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        //error
        if (state is RegisterErrorState) {
          context.loaderOverlay.hide();
          alertDialog(
              context: context,
              title: LocaleKeys.error.tr(),
              content: LocaleKeys.error_msg_reg.tr());
        }
        //success
        if (state is RegisterSuccesstState) {
          if (state.usermodel.status) {
            SharedPrefrenceseHelper.setData(
                    key: 'token', value: 'Bearer ${state.usermodel.token}')
                .then((value) {
              if (value) {
                SharedPrefrenceseHelper.setData(
                    key: 'name', value: state.usermodel.userData!.name);
                SharedPrefrenceseHelper.setData(
                    key: 'firstname', value: firstname.text);
                SharedPrefrenceseHelper.setData(
                    key: 'lastname', value: lastname.text);
                SharedPrefrenceseHelper.setData(
                    key: 'password', value: password.text);
                SharedPrefrenceseHelper.setData(
                    key: 'email', value: state.usermodel.userData!.email);
                context.loaderOverlay.hide();
                RegisterCubit.get(context).resetController(
                    firstname, lastname, email, password, passwordconfirmation);
                navigatepushAndRemoveUntil(context, const LayoutScreen());
              }
            });
          }
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return LoaderOverlay(
          useDefaultLoading: true,
          overlayColor: Colors.black,
          overlayOpacity: 0.3,
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: defaultappBar(context: context),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.create_accont.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.first_name.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.grey,
                                          )),
                                  defaultTextFormFaild(
                                      controller: firstname,
                                      type: TextInputType.name,
                                      action: TextInputAction.next,
                                      valid: (val) {
                                        if (val.isEmpty) {
                                          return LocaleKeys.valid_firstname
                                              .tr();
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.last_name.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Colors.grey,
                                          )),
                                  defaultTextFormFaild(
                                      controller: lastname,
                                      type: TextInputType.name,
                                      action: TextInputAction.next,
                                      valid: (val) {
                                        if (val.isEmpty) {
                                          return LocaleKeys.valid_lastname.tr();
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                action: TextInputAction.next,
                                valid: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.valid_password.tr();
                                  }
                                  if (val.length < 8) {
                                    return LocaleKeys.check_password.tr();
                                  }
                                  return null;
                                },
                                ispassword: cubit.isPassword,
                                suffixicon: cubit.isPassword
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                changepassword: () {
                                  cubit.changeVisibiltPassword();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.password_confirmation.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    )),
                            defaultTextFormFaild(
                                controller: passwordconfirmation,
                                type: TextInputType.text,
                                action: TextInputAction.done,
                                valid: (val) {
                                  if (val.isEmpty) {
                                    return LocaleKeys.valid_confirm_password
                                        .tr();
                                  }

                                  return null;
                                },
                                ispassword: cubit.isPasswordconfirmation,
                                suffixicon: cubit.isPasswordconfirmation
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off_outlined),
                                changepassword: () {
                                  cubit.changeVisibiltPasswordconfirmation();
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.Mycolor,
                            borderRadius: BorderRadius.circular(10),
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
                                    if (password.text !=
                                        passwordconfirmation.text) {
                                      defaultSnakbar(
                                          content: LocaleKeys
                                              .check_password_similarity
                                              .tr(),
                                          color: Colors.red,
                                          context: context);
                                    } else {
                                      context.loaderOverlay.show();
                                      cubit.registerFun(
                                          name:
                                              '${firstname.text} ${lastname.text}',
                                          email: email.text,
                                          password: password.text,
                                          passwordconfirmation:
                                              passwordconfirmation.text);
                                    }
                                  }
                                } else {
                                  defaultSnakbar(
                                      content: LocaleKeys.check_internt.tr(),
                                      color: Colors.red,
                                      context: context);
                                }
                              },
                              title: LocaleKeys.create_accont.tr()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Text(LocaleKeys.Do_you_have_an_account.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey)),
                            const SizedBox(
                              width: 3.0,
                            ),
                            InkWell(
                                onTap: () => navigateBack(context),
                                child: Text(LocaleKeys.login_now.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.Mycolor))),
                          ],
                        )
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
