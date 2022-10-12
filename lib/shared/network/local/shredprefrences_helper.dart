import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceseHelper {
  static late SharedPreferences sharedPre;

  //initSharedPrefrences.
  static Future<SharedPreferences> initsSharedPredfrencese() async {
    return sharedPre = await SharedPreferences.getInstance();
  }

  //SetData
  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is int) return await sharedPre.setInt(key, value);
    if (value is String) return await sharedPre.setString(key, value);
    if (value is bool) return await sharedPre.setBool(key, value);
    return await sharedPre.setDouble(key, value);
  }

  //getData
  static dynamic getData({required String? key}) {
    return sharedPre.get(key!);
  }

  //remove
  static Future<bool> remove({required String key}) async {
    return await sharedPre.remove(key);
  }
}
