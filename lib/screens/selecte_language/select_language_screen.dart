import 'package:doctorapp/screens/intro/intro_screen.dart';
import 'package:doctorapp/screens/login/login_screen.dart';
import 'package:doctorapp/screens/selecte_language/cubit/select_language_cubit.dart';
import 'package:doctorapp/screens/selecte_language/cubit/select_language_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectlanguageScreen extends StatelessWidget {
  const SelectlanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectlanguageCubit, SelectlanguageStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SelectlanguageCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.welcome_massage.tr(),
                      style: Theme.of(context).textTheme.titleLarge),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.selectLanguage.tr()),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(LocaleKeys.selectLangApp.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.grey)),
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
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                      color: cubit.isar
                                          ? Colors.Mycolor
                                          : Colors.grey)),
                              child: defaultListTitle(
                                title: const Text('اللغة العربية'),
                                leading: Image.asset(
                                  'assets/images/ar.png',
                                  height: 40,
                                ),
                                trailing: cubit.isar
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.Mycolor,
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
                                color: cubit.isar == false
                                    ? Colors.white
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                    color: cubit.isar == false
                                        ? Colors.Mycolor
                                        : Colors.grey)),
                            child: defaultListTitle(
                              title: const Text('English'),
                              leading: Image.asset(
                                'assets/images/en.png',
                                height: 40,
                              ),
                              trailing: cubit.isar == false
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: Colors.Mycolor,
                                    )
                                  : const SizedBox(
                                      width: 0.0,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.Mycolor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: defaultButton(
                              onPressed: () {
                                navigateTo(context, IntroScreen());
                                cubit.saveLange(context);
                              },
                              title: LocaleKeys.next.tr(),
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
