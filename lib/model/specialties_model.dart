class SpecialtiesModel {
  late bool status;
  late String message;
  late String token;
  SpecialtiesList? specialtiesList;

  SpecialtiesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    specialtiesList = SpecialtiesList.fromJson(json['specialties']);
  }
}

class SpecialtiesList {
  late List<SpecialtieDataModel> listspecialties = [];
  late List<SpecialtieDataModel> filter = [];
  SpecialtiesList.fromJson(List<dynamic> list) {
    list.forEach((element) {
      listspecialties.add(SpecialtieDataModel.fromJson(element));
      filter = listspecialties;
    });
  }
}

class SpecialtieDataModel {
  late int id;
  late String specialtiename;

  SpecialtieDataModel.fromJson(dynamic json) {
    id = json['id'];
    specialtiename = json['specialtie_name'];
  }
}
