class UserModel {
  late bool status;
  late String message;
  late String token;
  UserData? userData;
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    userData = UserData.fromJson(json['user']);
  }
}

class UserData {
  late int id;
  late String name;
  late String email;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}
