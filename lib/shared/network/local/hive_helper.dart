import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  static late Box box;

  static initsHive() async {
    var dir = await getApplicationDocumentsDirectory();
    return await Hive.initFlutter(dir.path);
  }

  static creatBox() async {
    return box = await Hive.openBox('data');
  }

  static Future add(
      {required String key, required Map<String, dynamic> values}) async {
    return await box.put(key, values);
  }

  static get({required String key}) {
    return box.get(key);
  }
}
