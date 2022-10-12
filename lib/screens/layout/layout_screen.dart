import 'package:doctorapp/screens/layout/cubit/layout_cubit.dart';
import 'package:doctorapp/screens/layout/cubit/layout_states.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 1.0)],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0))),
              child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: cubit.index,
                  onTap: (value) {
                    cubit.chabgeBottomNavBar(value);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled),
                        label: LocaleKeys.home.tr()),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: LocaleKeys.myaccount.tr()),
                  ]),
            ),
            body: cubit.screen[cubit.index],
          );
        },
      );
  }
}
