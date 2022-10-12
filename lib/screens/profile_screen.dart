import 'package:doctorapp/screens/edit_profile/edit_profile_screen.dart';
import 'package:doctorapp/screens/layout/cubit/layout_cubit.dart';
import 'package:doctorapp/screens/layout/cubit/layout_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/components/constinces.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LayoutCubit.get(context).getcurrentlang(context);
      return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.Mycolor,
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: defaultListTitle(
                        leading: Container(
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SharedPrefrenceseHelper.getData(key: 'name'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              SharedPrefrenceseHelper.getData(key: 'email'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        )),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 0.0),
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        defaultListTitle(
                          onTap: () => navigateTo(context, EditProfileScreen()),
                          title: Text(
                            LocaleKeys.edit_profile.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          leading: const Icon(
                            Icons.person_outline,
                            color: Colors.Mycolor,
                          ),
                          trailing: EasyLocalization.of(context)!
                                      .locale
                                      .countryCode ==
                                  'ar'
                              ? const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                ),
                        ),
                        const Divider(
                          height: 10,
                        ),
                        defaultListTitle(
                            title: Text(
                              LocaleKeys.language.tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            leading: const Icon(
                              Icons.language_outlined,
                              color: Colors.Mycolor,
                            ),
                            trailing: EasyLocalization.of(context)!
                                        .locale
                                        .countryCode ==
                                    'ar'
                                ? const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 18,
                                  )
                                : const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  builder: (context) {
                                    return BlocConsumer<LayoutCubit,
                                        LayoutStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        var cubit = LayoutCubit.get(context);
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(LocaleKeys.selectLanguage
                                                    .tr()),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.changeLanguageAr();
                                                  },
                                                  child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: cubit.isar
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          border: Border.all(
                                                              color: cubit.isar
                                                                  ? Colors
                                                                      .Mycolor
                                                                  : Colors
                                                                      .grey)),
                                                      child: defaultListTitle(
                                                        title: const Text(
                                                            'اللغة العربية'),
                                                        leading: Image.asset(
                                                          'assets/images/ar.png',
                                                          height: 40,
                                                        ),
                                                        trailing: cubit.isar
                                                            ? const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .Mycolor,
                                                              )
                                                            : SizedBox(
                                                                width: 0.0,
                                                              ),
                                                      )),
                                                ),
                                                const SizedBox(
                                                  height: 20.0,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.changeLanguageEn();
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: cubit.isar ==
                                                                false
                                                            ? Colors.white
                                                            : Colors.grey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                            color: cubit.isar ==
                                                                    false
                                                                ? Colors.Mycolor
                                                                : Colors.grey)),
                                                    child: defaultListTitle(
                                                      title:
                                                          const Text('English'),
                                                      leading: Image.asset(
                                                        'assets/images/en.png',
                                                        height: 40,
                                                      ),
                                                      trailing:
                                                          cubit.isar == false
                                                              ? const Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .Mycolor,
                                                                )
                                                              : const SizedBox(
                                                                  width: 0.0,
                                                                ),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.Mycolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: defaultButton(
                                                      onPressed: () {
                                                        navigateBack(context);
                                                        cubit
                                                            .saveLange(context);
                                                      },
                                                      title:
                                                          LocaleKeys.save.tr(),
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            }),
                        const Divider(
                          height: 10,
                        ),
                        defaultListTitle(
                          title: Text(
                            LocaleKeys.about_us.tr(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          leading: const Icon(
                            Icons.info_outline,
                            color: Colors.Mycolor,
                          ),
                          trailing: EasyLocalization.of(context)!
                                      .locale
                                      .countryCode ==
                                  'ar'
                              ? const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                )
                              : const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                ),
                        ),
                        const Divider(
                          height: 10,
                        ),
                        defaultListTitle(
                            title: Text(
                              LocaleKeys.logout.tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            leading: const Icon(
                              Icons.logout_outlined,
                              color: Colors.Mycolor,
                            ),
                            trailing: EasyLocalization.of(context)!
                                        .locale
                                        .countryCode ==
                                    'ar'
                                ? const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 18,
                                  )
                                : const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                  ),
                            onTap: () {
                              alertDialogLogout(
                                  context: context,
                                  title: LocaleKeys.logout.tr(),
                                  content: LocaleKeys.logout_msg.tr(),
                                  ok: LocaleKeys.yes.tr(),
                                  cancle: LocaleKeys.no.tr(),
                                  ontabOk: () {
                                    LayoutCubit.get(context).index = 0;
                                    logout(context);
                                  },
                                  ontabCancle: () {
                                    navigateBack(context);
                                  });
                            }),
                        const Divider(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            )),
          );
        },
      );
    });
  }
}
