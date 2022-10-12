import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:doctorapp/screens/edit_profile/cubit/edit_profile_states.dart';
import 'package:doctorapp/screens/layout/layout_screen.dart';
import 'package:doctorapp/screens/profile_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var lastname = TextEditingController();
  var email = TextEditingController();
  var oldpassword = TextEditingController();
  var newpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // firstname.text = SharedPrefrenceseHelper.getData(key: 'firstname');
    name.text = SharedPrefrenceseHelper.getData(key: 'name');
    email.text = SharedPrefrenceseHelper.getData(key: 'email');
    return Builder(builder: (context) {
      EditProfileCubit.get(context).resetFile();
      return BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {
          //error
          if (state is EditProfileErrorState) {
            context.loaderOverlay.hide();
            alertDialog(
                context: context,
                title: LocaleKeys.error.tr(),
                content: state.error);
          }
          //success
          if (state is EditProfileSuccesstState) {
            if (state.usermodel.status) {
              SharedPrefrenceseHelper.setData(
                  key: 'name', value: state.usermodel.userData!.name);
              SharedPrefrenceseHelper.setData(
                  key: 'email', value: state.usermodel.userData!.email);
              SharedPrefrenceseHelper.setData(key: 'name', value: name.text);
              SharedPrefrenceseHelper.setData(
                  key: 'lastname', value: lastname.text);

              context.loaderOverlay.hide();
              navigatepushAndRemoveUntil(context, const LayoutScreen());
              defaultSnakbar(
                  content: LocaleKeys.edited_successfully.tr(),
                  color: Colors.green,
                  context: context);
            }
          }
        },
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);
          return LoaderOverlay(
            useDefaultLoading: true,
            overlayColor: Colors.black,
            overlayOpacity: 0.3,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: defaultappBar(
                context: context,
                title: LocaleKeys.edit_profile.tr(),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(blurRadius: 1)]),
                                  child: cubit.profileFile != null
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage:
                                              FileImage(cubit.profileFile!),
                                          radius: 62,
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                              'assets/images/profile.jpg'),
                                          radius: 62,
                                        ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      cubit.selectedImage(1);
                                                      navigateBack(context);
                                                    },
                                                    child: Wrap(
                                                      direction: Axis.vertical,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          child: Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(LocaleKeys.camera
                                                            .tr())
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cubit.selectedImage(2);
                                                      navigateBack(context);
                                                    },
                                                    child: Wrap(
                                                      direction: Axis.vertical,
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        const CircleAvatar(
                                                          backgroundColor:
                                                              Colors.deepPurple,
                                                          child: Icon(
                                                            Icons.image,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                        Text(LocaleKeys.gallery
                                                            .tr())
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const CircleAvatar(
                                        child: Icon(Icons.camera_alt)))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.name.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              defaultTextFormFaild(
                                  controller: name,
                                  type: TextInputType.name,
                                  action: TextInputAction.next,
                                  valid: (val) {
                                    if (val.isEmpty) {
                                      return LocaleKeys.valid_name.tr();
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
                              Text(LocaleKeys.oldpassword.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              defaultTextFormFaild(
                                  controller: oldpassword,
                                  type: TextInputType.text,
                                  action: TextInputAction.next,
                                  valid: (val) {
                                    if (val.isEmpty &&
                                        newpassword.text.isNotEmpty) {
                                      return LocaleKeys.valid_oldpassword.tr();
                                    }

                                    return null;
                                  },
                                  ispassword: cubit.isOldPassword,
                                  suffixicon: cubit.isOldPassword
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                  changepassword: () {
                                    cubit.changeVisibiltOldPassword();
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.newpassword.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.grey,
                                      )),
                              defaultTextFormFaild(
                                  controller: newpassword,
                                  type: TextInputType.text,
                                  action: TextInputAction.done,
                                  valid: (val) {
                                    if (val.isEmpty &&
                                        oldpassword.text.isNotEmpty) {
                                      return LocaleKeys.valid_newpassword.tr();
                                    }

                                    return null;
                                  },
                                  ispassword: cubit.isNewPassword,
                                  suffixicon: cubit.isNewPassword
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(
                                          Icons.visibility_off_outlined),
                                  changepassword: () {
                                    cubit.changeVisibiltNewPassword();
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
                                  var connectivityResult = await (Connectivity()
                                      .checkConnectivity());
                                  if (connectivityResult ==
                                          ConnectivityResult.mobile ||
                                      connectivityResult ==
                                          ConnectivityResult.wifi) {
                                    if (formkey.currentState!.validate()) {
                                      if (oldpassword.text.isNotEmpty &&
                                          oldpassword.text !=
                                              SharedPrefrenceseHelper.getData(
                                                  key: 'password')) {
                                        defaultSnakbar(
                                            content: LocaleKeys
                                                .incorrect_oldpassword
                                                .tr(),
                                            color: Colors.red,
                                            context: context);
                                      } else {
                                        context.loaderOverlay.show();
                                        cubit.editProfileFun(
                                            name: name.text,
                                            email: email.text,
                                            newpassword:
                                                newpassword.text.isNotEmpty
                                                    ? newpassword.text
                                                    : null);
                                      }
                                    }
                                  } else {
                                    defaultSnakbar(
                                        content: LocaleKeys.check_internt.tr(),
                                        color: Colors.red,
                                        context: context);
                                  }
                                },
                                title: LocaleKeys.edit.tr()),
                          ),
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
    });
  }
}
