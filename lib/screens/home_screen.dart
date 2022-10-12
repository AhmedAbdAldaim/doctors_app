import 'package:doctorapp/screens/medicalcenters/medicalc_center_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/components/constinces.dart';
import 'package:doctorapp/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
               Align(alignment: AlignmentDirectional.topEnd ,child: Image.asset('assets/images/logo1.png', height: 100,) ,),
              ListTile(
                  title: Text(LocaleKeys.title1.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.red.shade800)),
                     subtitle: Text(LocaleKeys.title2.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black54)),
                   
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  children: [
                    InkWell(
                      onTap: ()=> navigateTo(context, MedicalCenterScreen()),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/medical1.png', width: 50, height: 50,),
                              const SizedBox(height: 10.0,),
                              Text(LocaleKeys.find_doctor.tr()),
                            ],
                          ),
                        ),
                      ),
                    ),
                     Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/medical2.png', width: 50, height: 50,),
                            const SizedBox(height: 10.0,),
                            Text(LocaleKeys.medical_consultation.tr()),
                          ],
                        ),
                                         ),
                     )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
