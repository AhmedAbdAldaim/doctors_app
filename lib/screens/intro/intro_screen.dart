import 'package:doctorapp/screens/intro/cubit/intro_cubit.dart';
import 'package:doctorapp/screens/intro/cubit/intro_states.dart';
import 'package:doctorapp/screens/login/login_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/shredprefrences_helper.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroCubit, IntroStates>(
      listener: (context, states) {},
      builder: (context, state) {
        var cubit = IntroCubit.get(context);
        return SafeArea(
          child: Center(
            child: IntroductionScreen(
              next: CircleAvatar(
                  child: CircularStepProgressIndicator(
                      roundedCap: (_, __) => true,
                      totalSteps: 3,
                      currentStep: cubit.step,
                      selectedColor: Colors.amber,
                      unselectedColor: Colors.grey[200],
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ))),
              back: const Text('data'),
              onChange: (val) {
                cubit.changeStaep(val + 1);
              },
              skip: Text(LocaleKeys.skip.tr()),
              showSkipButton: true,
              done: CircleAvatar(
                backgroundColor: Colors.Mycolor,
                child: CircularStepProgressIndicator(
                  roundedCap: (_, __) => true,
                  totalSteps: 3,
                  currentStep: 3,
                  selectedColor: Colors.amber,
                  unselectedColor: Colors.grey[200],
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              animationDuration: 800,
              onDone: () {
                SharedPrefrenceseHelper.setData(value: true, key: 'intro')
                    .then((value) {
                  navigatepushAndRemoveUntil(context, LoginScreen());
                });
              },
              dotsDecorator: DotsDecorator(
                  activeSize: const Size(22, 10),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
              pages: [
                PageViewModel(
                    title: LocaleKeys.intro1_title.tr(),
                    body: LocaleKeys.intro1_body.tr(),
                    image: Image.asset('assets/images/intro1.png'),
                    decoration: pageDecoration(context)),
                PageViewModel(
                    title: LocaleKeys.intro2_title.tr(),
                    body: LocaleKeys.intro2_body.tr(),
                    image: Image.asset('assets/images/intro2.png'),
                    decoration: pageDecoration(context)),
                PageViewModel(
                    title: LocaleKeys.intro3_title.tr(),
                    body: LocaleKeys.intro3_body.tr(),
                    image: Image.asset('assets/images/intro3.png'),
                    decoration: pageDecoration(context))
              ],
            ),
          ),
        );
      },
    );
  }
}
