class DoctorsModel {
  late bool status;
  late String message;
  late String token;
  DoctorsList? doctorsList;

  DoctorsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    doctorsList = DoctorsList.fromJson(json['doctors']);
  }
}

class DoctorsList {
  late List<DataModeldoctors> listDoctor = [];
  late List<DataModeldoctors> filter = [] ;

  DoctorsList.fromJson(List<dynamic> list) {
    list.forEach((element) {
      listDoctor.add(DataModeldoctors.fromJson(element));
      filter = listDoctor;
    });
  }
}

class DataModeldoctors {
  late int id;
  late String name;
  late String phone;
  late String price;

  DataModeldoctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    price = json['price'];
  }
}
