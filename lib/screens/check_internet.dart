import 'package:doctorapp/screens/medicalcenters/medicalc_center_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:flutter/material.dart';

class CheckInternet extends StatelessWidget {
  final Widget widget;
  const CheckInternet({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'الرجاء التحقق من الاتصال بالانترنت',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            defaultButtonEle(
                onPressed: () {
                  navigateReplacement(context, widget);
                },
                title: 'حاول مرة اخرى',
                color: Colors.black,
                primayColor: Colors.white),
          ],
        ),
      ),
    ));
  }
}
