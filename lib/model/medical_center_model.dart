class MedicalCenterModel {
  late bool status;
  late String message;
  late String token;
  MedicalCenterList? medicalCenterList;

  MedicalCenterModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    medicalCenterList = MedicalCenterList.fromJson(json['medicalCenter']);
  }
}

class MedicalCenterList {
  late List<MedicalcenterDataModel> filter = [];
  late List<MedicalcenterDataModel> listataMedical = [];
  late List<MedicalcenterDataModel> local = [];
  MedicalCenterList.fromJson(List<dynamic> list) {
    list.forEach((element) {
      listataMedical.add(MedicalcenterDataModel.fromJson(element));
      filter = listataMedical;
      local = listataMedical;
    });
  }
}

class MedicalcenterDataModel {
  late int id;
  late String name;
  late String address;
  MedicalcenterDataModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }
}
