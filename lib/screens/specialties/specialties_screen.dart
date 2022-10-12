import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/model/medical_center_model.dart';
import 'package:doctorapp/model/specialties_model.dart';
import 'package:doctorapp/screens/check_internet.dart';
import 'package:doctorapp/screens/doctors/doctors_screen.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_cubit.dart';
import 'package:doctorapp/screens/specialties/cubit/specialties_states.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:doctorapp/shared/network/remote/dio_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SpecialtiesScreen extends StatelessWidget {
  final MedicalcenterDataModel medicalCentermodel;
  const SpecialtiesScreen({Key? key, required this.medicalCentermodel}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SpecialtiesCubit.get(context).getSpecialtiesFun(context);
      SpecialtiesCubit.get(context).updateWhenOpenPagetSpecialtiesFun(context);

      return BlocConsumer<SpecialtiesCubit, SpecialtiesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SpecialtiesCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: RefreshIndicator(
                onRefresh: () async {
                  await cubit.refreshIndecatortSpecialtiesFun(context);
                },
                child: Scaffold(
                    appBar: defaultappBar(context: context, title: 'التخصصات'),
                    body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: HiveHelper.get(key: 'specialties') != null &&
                                cubit.onRefresh == false
                            ? cubit.specialtiesModel!.specialtiesList!
                                    .listspecialties.isEmpty
                                ? emptyData(
                                    context: context,
                                    massage: 'لا توجد تخصصات!')
                                : buildDesignSpecialized(cubit, medicalCentermodel)
                            : state is! GetSpecialtiesErrosState
                                ? ConditionalBuilder(
                                    condition:
                                        state is GetSpecialtiesSuccessState &&
                                            cubit.specialtiesModel != null,
                                    builder: (context) {
                                      return cubit
                                              .specialtiesModel!
                                              .specialtiesList!
                                              .listspecialties
                                              .isEmpty
                                          ? emptyData(
                                              context: context,
                                              massage: 'لا توجد تخصصات!')
                                          : buildDesignSpecialized(
                                              cubit, medicalCentermodel);
                                    },
                                    fallback: (context) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        defaultShimmer(
                                            child: Container(
                                          height: 45,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                        )),
                                        Expanded(
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: 10,
                                              itemBuilder: (context, i) =>
                                                  shimmerLoading()),
                                        ),
                                      ],
                                    ),
                                  )
                                : HiveHelper.get(key: 'specialties') != null
                                    ? cubit.specialtiesModel!.specialtiesList!
                                            .listspecialties.isEmpty
                                        ? emptyData(
                                            context: context,
                                            massage: 'لا توجد تخصصات!')
                                        : buildDesignSpecialized(cubit, medicalCentermodel)
                                    : checkServer(
                                        context: context,
                                        widget: SpecialtiesScreen(
                                          medicalCentermodel:
                                              medicalCentermodel,
                                        )))),
              ));
        },
      );
    });
  }

}

Widget buildDesignSpecialized(SpecialtiesCubit cubit, model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          child: defaultTextFormFaildSearch(
            onChanged: (val) => cubit.searchSpecialties(val),
            hint: 'ابحث عن تخصص',
            icon: const Icon(Icons.search),
            action: TextInputAction.done,
            type: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.separated(
              itemCount: cubit.specialtiesModel!.specialtiesList!.filter.length,
              itemBuilder: (context, index) {
                return buildItemSpecialte(
                  context,
                  model,
                  cubit.specialtiesModel!.specialtiesList!.filter[index],
                );
              },
              separatorBuilder: (context, index) => const Divider()),
        ),
      ],
    );

Widget buildItemSpecialte(context, MedicalcenterDataModel medicalcenterModel,
        SpecialtieDataModel specialteModel) =>
    InkWell(
      onTap: () {
        navigateTo(
            context,
            DoctorsScreen(
                modelMedicalcenter: medicalcenterModel,
                modelSpecialtie: specialteModel));
      },
      child: defaultListTitle(
        leading: const Image(
          image: AssetImage('assets/images/logo.png'),
        ),
        title: Text(specialteModel.specialtiename,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w400)),
      ),
    );

Shimmer shimmerLoading() {
  return defaultShimmer(
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
