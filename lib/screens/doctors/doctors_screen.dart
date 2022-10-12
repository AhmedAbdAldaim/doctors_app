import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctorapp/model/doctors_model.dart';
import 'package:doctorapp/model/medical_center_model.dart';
import 'package:doctorapp/model/specialties_model.dart';
import 'package:doctorapp/screens/doctors/cubit/doctors_cubit.dart';
import 'package:doctorapp/screens/doctors/cubit/doctors_states.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_cubit.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_states.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_cubit.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DoctorsScreen extends StatelessWidget {
  final MedicalcenterDataModel modelMedicalcenter;
  final SpecialtieDataModel modelSpecialtie;

  var searchController = TextEditingController();
  DoctorsScreen(
      {Key? key,
      required this.modelMedicalcenter,
      required this.modelSpecialtie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      DoctorsCubit.get(context).getDoctorsFun(
          context: context,
          medicalCenterID: modelMedicalcenter.id,
          specialteID: modelSpecialtie.id);
      return BlocConsumer<DoctorsCubit, DoctorsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DoctorsCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Colors.grey[100],
                appBar: defaultappBar(
                    context: context, title: 'كل الأطباء', elevation: 0.0),
                body: state is! GetDoctorsErrosState
                    ? ConditionalBuilder(
                        condition: state is GetDoctorsSuccessState &&
                            cubit.doctorsModel != null,
                        builder: (context) =>
                            cubit.doctorsModel!.doctorsList!.listDoctor.isEmpty
                                ? emptyData(
                                    context: context,
                                    massage: 'لا يوجد أي اطباء!')
                                : Column(
                                    children: [
                                      Card(
                                        color: Colors.white,
                                        margin: const EdgeInsets.all(0.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  top: 16.0,
                                                  start: 16.0,
                                                  end: 16.0,
                                                  bottom: 5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                             
                                              Container(
                                                color: Colors.white,
                                                child:
                                                    defaultTextFormFaildSearch(
                                                  onChanged: (val) =>
                                                      cubit.searchDoctor(val),
                                                  hint: 'ابحث عن طبيب',
                                                  icon: Icon(Icons.search),
                                                  action: TextInputAction.done,
                                                  type: TextInputType.text,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return BlocConsumer<
                                                                      SpecialtiesCubit,
                                                                      SpecialtiesStates>(
                                                                  listener:
                                                                      (c, s) {},
                                                                  builder:
                                                                      (c, s) {
                                                                    var cubits =
                                                                        SpecialtiesCubit.get(
                                                                            context);

                                                                    return Container(
                                                                      height:
                                                                          MediaQuery.of(context).size.height /
                                                                              2,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(20.0),
                                                                        child: Column(
                                                                          children: [
                                                                            Container(
                                                                              height: 10,
                                                                              width: 40,
                                                                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                                                            ),
                                                                            const SizedBox(height: 20,),
                                                                           
                                                                            Expanded(
                                                                              child: ListView.separated(
                                                                                  itemBuilder: (context, i) {
                                                                                    return InkWell(
                                                                                      onTap: () {

                                                                                        navigateBack(context);
                                                                                        navigateReplacement(context, DoctorsScreen(modelMedicalcenter: modelMedicalcenter, modelSpecialtie: cubits.specialtiesModel!.specialtiesList!.listspecialties[i]));
                                                                                      },
                                                                                      child: Center(child: Container(padding: const EdgeInsets.all(10), child: Text(cubits.specialtiesModel!.specialtiesList!.filter[i].specialtiename))),
                                                                                    );
                                                                                  },
                                                                                  separatorBuilder: (context, i) => const Divider(
                                                                                        height: 10,
                                                                                      ),
                                                                                  itemCount: cubits.specialtiesModel!.specialtiesList!.filter.length),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                      },
                                                      child: Card(
                                                        color: Colors.grey[300],
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20)
                                                        ),
                                                        child: Row(children: [
                                                          Expanded(
                                                            child: Text(
                                                                modelSpecialtie
                                                                    .specialtiename,
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis)),
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .arrow_drop_down_rounded,
                                                              size: 30,
                                                              color:
                                                                  Colors.black),
                                                    
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return BlocConsumer<
                                                                      MedicalcentersCubit,
                                                                      MedicalcentersStates>(
                                                                  listener:
                                                                      (c, s) {},
                                                                  builder:
                                                                      (c, s) {
                                                                    var cubits =
                                                                        MedicalcentersCubit.get(
                                                                            context);

                                                                    return Container(
                                                                      height:
                                                                          MediaQuery.of(context).size.height /
                                                                              2,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(20.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              height: 10,
                                                                              width: 40,
                                                                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(20)),
                                                                            ),
                                                                            const SizedBox(height: 20,),
                                                                            Expanded(
                                                                              child: ListView.separated(
                                                                                  itemBuilder: (context, i) {
                                                                                    return InkWell(
                                                                                      onTap: () {
                                                                                        navigateBack(context);
                                                                                        navigateReplacement(context, DoctorsScreen(modelMedicalcenter: cubits.medicalCenterMode!.medicalCenterList!.listataMedical[i], modelSpecialtie: modelSpecialtie));
                                                                                      },
                                                                                      child: Center(child: Container(padding: const EdgeInsets.all(10), child: Text(cubits.medicalCenterMode!.medicalCenterList!.listataMedical[i].name))),
                                                                                    );
                                                                                  },
                                                                                  separatorBuilder: (context, i) => const Divider(
                                                                                        height: 10,
                                                                                      ),
                                                                                  itemCount: cubits.medicalCenterMode!.medicalCenterList!.filter.length),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            });
                                                      },
                                                      child: Card(
                                                        color: Colors.grey[300],
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20)
                                                        ),
                                                        child: Row(children: [
                                                          Expanded(
                                                            child: Text(
                                                                modelMedicalcenter
                                                                    .name,
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis)),
                                                          ),
                                                          Icon(
                                                              Icons
                                                                  .arrow_drop_down_rounded,
                                                              size: 30,
                                                              color:
                                                                  Colors.black),
                                                          //   Container(
                                                          //       padding:
                                                          //           const EdgeInsets
                                                          //                   .symmetric(
                                                          //               horizontal:
                                                          //                   8,
                                                          //               vertical:
                                                          //                   3),

                                                          //       child: Text(
                                                          //           modelMedicalcenter
                                                          //               .name,
                                                          //           maxLines: 1,
                                                          //           overflow: TextOverflow
                                                          //                     .ellipsis,
                                                          //           style:
                                                          //               TextStyle(
                                                          //             overflow:
                                                          //                 TextOverflow
                                                          //                     .ellipsis,
                                                          //             color: Colors
                                                          //                 .black,
                                                          //           ))),
                                                        ]),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListView.separated(
                                            itemCount: cubit.doctorsModel!
                                                .doctorsList!.filter.length,
                                            itemBuilder: (context, index) {
                                              return buildItemDoctor(
                                                  context,
                                                  cubit
                                                      .doctorsModel!
                                                      .doctorsList!
                                                      .filter[index],
                                                  modelMedicalcenter,
                                                  modelSpecialtie);
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        fallback: (context) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: defaultShimmer(
                               child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                              )),
                            ),
                            defaultShimmer(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                  ))
                                ],
                              ),
                            )),
                            Expanded(
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, i) =>
                                      shimmerLoading()),
                            ),
                          ],
                        ),
                      )
                    : checkServer(
                        context: context,
                        widget: DoctorsScreen(
                            modelMedicalcenter: modelMedicalcenter,
                            modelSpecialtie: modelSpecialtie)),
              ));
        },
      );
    });
  }
}

Widget buildItemDoctor(
        context,
        DataModeldoctors model,
        MedicalcenterDataModel modelMedicalCenter,
        SpecialtieDataModel modelspecialtie) =>
    InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)]),
        child: Column(
          children: [
            defaultListTitle(
            contentPadding: const EdgeInsets.all(10.0),
            leading: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle
              ),
              child: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("د." + model.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w600 ,color: Colors.Mycolor)),
                const SizedBox(height: 4.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital, size:20,color: Colors.grey),
                    const SizedBox(width: 4.0,),
                    Expanded(
                      child: Text(
                          modelMedicalCenter.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                    ),
                  ],
                ),
                  const SizedBox(height: 4.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.earbuds, size:20,color: Colors.grey),
                    const SizedBox(width: 4.0,),
                    Expanded(
                      child: Text(
                          modelspecialtie.specialtiename,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black))
                    ),
                  ],
                ),
                  const SizedBox(height: 4.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.attach_money_sharp, size:20 , color: Colors.grey),
                    const SizedBox(width: 3.0,),
                    Expanded(
                      child: Text(model.price + ' جنيه سوداني ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
            ),    
            Container(
              alignment: AlignmentDirectional.bottomEnd,
              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade900,
                  side: BorderSide(color: Colors.white)
                ),
                child: Text('التفاصيل' , 
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),))
            )
          ],
        ) ),
    );

Shimmer shimmerLoading() {
  return defaultShimmer(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        child: Column(
          
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                  width: 10,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 10,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
                    width: double.infinity,
                    height: 30,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  )
          ],
        ),
      ),
    ),
  );
}
