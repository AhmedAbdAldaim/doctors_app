import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctorapp/model/medical_center_model.dart';
import 'package:doctorapp/screens/check_internet.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_cubit.dart';
import 'package:doctorapp/screens/medicalcenters/cubit/medicalcenters_states.dart';
import 'package:doctorapp/screens/specialties/specialties_screen.dart';
import 'package:doctorapp/shared/components/components.dart';
import 'package:doctorapp/shared/network/local/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MedicalCenterScreen extends StatelessWidget {
  const MedicalCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      MedicalcentersCubit.get(context).getMedicalcentersFun(context);
      MedicalcentersCubit.get(context).updateWhenOpenPagetMedicalcentersFun(context);

      return BlocConsumer<MedicalcentersCubit, MedicalcentersStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = MedicalcentersCubit.get(context);
            print(HiveHelper.get(key: 'medicalcenters') != null);
            return Directionality(
                textDirection: TextDirection.rtl,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await cubit.refreshIndecatortMedicalcentersFun(context);
                  },
                  child: Scaffold(
                      backgroundColor: Colors.grey[100],
                      appBar: defaultappBar(
                          context: context, title: 'المراكز الصحية'),
                      body: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: HiveHelper.get(key: 'medicalcenters') !=
                                      null &&
                                  cubit.onRefresh == false
                              ? cubit.medicalCenterMode!.medicalCenterList!
                                      .listataMedical.isEmpty
                                  ? emptyData(
                                      context: context,
                                      massage: 'لا توجد مراكز صحية!')
                                  : buildDesignMedicalCenters(cubit)
                              : state is! GetMedicalCentersErrosState
                                  ? ConditionalBuilder(
                                      condition: State
                                              is GetMedicalCentersSuccessState &&
                                          cubit.medicalCenterMode != null,
                                      builder: (context) {
                                        return cubit
                                                .medicalCenterMode!
                                                .medicalCenterList!
                                                .listataMedical
                                                .isEmpty
                                            ? emptyData(
                                                context: context,
                                                massage: 'لا توجد مراكز صحية!')
                                            : buildDesignMedicalCenters(cubit);
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
                                          )
                                        ],
                                      ),
                                    )
                                  : HiveHelper.get(key: 'medicalcenters') !=
                                          null
                                      ? cubit
                                              .medicalCenterMode!
                                              .medicalCenterList!
                                              .listataMedical
                                              .isEmpty
                                          ? emptyData(
                                              context: context,
                                              massage: 'لا توجد مراكز صحية!')
                                          : buildDesignMedicalCenters(cubit)
                                      : checkServer(
                                          context: context,
                                          widget:
                                              const MedicalCenterScreen()))),
                ));
          });
    });
  }
}

Widget buildDesignMedicalCenters(MedicalcentersCubit cubit) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          child: defaultTextFormFaildSearch(
            onChanged: (val) => cubit.searchMedicalCenter(val),
            hint: 'ابحث عن المستشفى او الموقع',
            icon: Icon(Icons.search),
            action: TextInputAction.done,
            type: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.separated(
              itemCount:
                  cubit.medicalCenterMode!.medicalCenterList!.filter.length,
              itemBuilder: (context, index) {
                return buildItemMedicalCenter(
                    cubit.medicalCenterMode!.medicalCenterList!.filter[index],
                    context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  )),
        ),
      ],
    );

Widget buildItemMedicalCenter(MedicalcenterDataModel model, context) => InkWell(
    onTap: () {
      navigateTo(
          context,
          SpecialtiesScreen(
            medicalCentermodel: model,
          ));
    },
    child: Card(
      child: defaultListTitle(
          contentPadding: const EdgeInsets.all(16),
          leading: const Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          title: Text(
            model.name,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          subtilte: Text(model.address),
          trailing: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.Mycolor.withOpacity(0.8),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.white,
            ),
          )),
    ));

Shimmer shimmerLoading() {
  return defaultShimmer(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10.0,
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
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
          )
        ],
      ),
    ),
  );
}
