import 'dart:ffi';

import 'package:another_flushbar/flushbar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctorapp/shared/components/constinces.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shimmer/shimmer.dart';

//TextFormField
Widget defaultTextFormFaild(
    {TextEditingController? controller,
    required TextInputType type,
    String? hint,
    required TextInputAction action,
    Icon? icon,
    required FormFieldValidator valid,
    bool ispassword = false,
    Icon? suffixicon,
    VoidCallback? changepassword,
    ValueChanged<String>? onChanged}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: const TextStyle(fontFamily: 'ar_font'),
    onChanged: onChanged,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'ar_font'),
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.red)),
        suffixIcon: suffixicon != null
            ? IconButton(onPressed: changepassword, icon: suffixicon)
            : null),
    obscureText: ispassword,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: valid,
    textInputAction: action,
  );
}

//TextFormField
Widget defaultTextFormFaildSearch(
    {required TextInputType type,
    String? hint,
    required TextInputAction action,
    Icon? icon,
    ValueChanged<String>? onChanged}) {
  return TextFormField(
    keyboardType: type,
    style: const TextStyle(fontFamily: 'ar_font'),
    onChanged: onChanged,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(3),
      hintText: hint,
      hintStyle: const TextStyle(fontFamily: 'ar_font'),
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Colors.red)),
    ),
    textInputAction: action,
  );
}

//Material Button
Widget defaultButton({
  required VoidCallback onPressed,
  required String title,
  required Color color,
}) {
  return MaterialButton(
    onPressed: onPressed,
    padding: const EdgeInsets.all(10.0),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(color: color),
    ),
  );
}

//Eleve Button
Widget defaultButtonEle(
    {required VoidCallback onPressed,
    required String title,
    required Color color,
    bool? raduis = false,
    Color? side,
    required Color primayColor}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(primary: primayColor, shape: raduis==true? RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ): null),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(color: color),
    ),
  );
}

//navigat to PUSH
Future navigateTo(BuildContext context, widget) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

//navigat to PUSH
navigateReplacement(BuildContext context, widget) {
  return Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}

//navigat and replace
navigatepushAndRemoveUntil(BuildContext context, widget) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

//navigat to POP
navigateBack(BuildContext context) {
  return Navigator.of(context).pop();
}

//appBar
defaultappBar({
  required BuildContext context,
  String? title,
  double?elevation,

}) {
  return AppBar(
    title: Text(title ?? '', style: Theme.of(context).textTheme.titleMedium),
    centerTitle: true,
    elevation: elevation??3.0,
    leading: IconButton(
        onPressed: () {
          navigateBack(context);
        },
        icon: Icon(Icons.arrow_back_ios_outlined)),
  );
}

//listTile
defaultListTitle(
    {required Widget title,
    Widget? leading,
    Widget? trailing,
    Widget? subtilte,
    double? minLeadingWidth,
    EdgeInsetsGeometry? contentPadding,
    GestureTapCallback? onTap}) {
  return ListTile(
    leading: leading, 
    minLeadingWidth: minLeadingWidth,
    contentPadding: contentPadding,
    title: title,
    trailing: trailing,
    subtitle: subtilte,
    onTap: onTap,
  );
}

defaultSnakbar(
    {required String content,
    required Color color,
    required BuildContext context}) {
  return Flushbar(
    message: content,
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(15),
    borderRadius: BorderRadius.circular(5),
  )..show(context);
}

//flutter Toast
defautToast({required String message, required StateToast state}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ToastColors(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum StateToast { SUCCES, ERROR, WRANG }

Color ToastColors(StateToast state) {
  late Color color;
  switch (state) {
    case StateToast.SUCCES:
      color = Colors.green;
      break;
    case StateToast.ERROR:
      color = Colors.red;
      break;
    case StateToast.WRANG:
      color = Colors.amber;
      break;
  }
  return color;
}

//Dialog
Future defaultDialog(
    {required BuildContext context,
    required String title,
    required String massage}) {
  return AwesomeDialog(
    context: context,
    body: Text(
      massage,
      textAlign: TextAlign.center,
    ),
    title: title,
    btnOkText: LocaleKeys.ok.tr(),
    btnOkOnPress: () {},
  ).show();
}

alertDialog({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Builder(builder: (contex) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red.shade900,
                      ),
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(content, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: MaterialButton(
                        color: Colors.Mycolor,
                        onPressed: () => navigateBack(context),
                        child: Text(
                          LocaleKeys.ok.tr(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            );
          }),
        );
      });
}

alertDialogLogout({
  required BuildContext context,
  required String title,
  required String content,
  required String ok,
  required String cancle,
  required VoidCallback ontabOk,
  required VoidCallback ontabCancle,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Builder(builder: (contex) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red.shade900,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ListTile(
                    title: Text(content,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            onPressed: ontabOk,
                            color: Colors.Mycolor,
                            padding: const EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            child: Text(
                              ok.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: MaterialButton(
                            onPressed: ontabCancle,
                            color: Colors.grey,
                            padding: const EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            child: Text(
                              cancle.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      });
}

//intro
PageDecoration pageDecoration(context) {
  return PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.titleMedium!,
      bodyTextStyle: Theme.of(context).textTheme.bodySmall!,
      imagePadding: const EdgeInsets.all(30));
}

Shimmer defaultShimmer({required Widget child }) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    direction: getCurrentLang() == 'ar' ? ShimmerDirection.rtl : ShimmerDirection.ltr,
    child: child,
  );
}

Widget checkInternet({required context, required widget}) => Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
    );

Widget checkServer({required context, required widget}) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 60,
            color: Colors.red,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('هناك خطأ في الإتصال بالخادم!',
              style: TextStyle(color: Colors.black)),
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
    );

Widget emptyData({required context, required String massage}) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.hourglass_empty_outlined,
            size: 60,
            color: Colors.red,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(massage,
              style: TextStyle(color: Colors.black)),
        ],
      ),
    );
