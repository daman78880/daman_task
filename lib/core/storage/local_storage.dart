import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class Prefs {
  Prefs._();

  static var box = GetStorage();

  static const String token = "token";
  static const String userLogin = "userLogin";
  static const String name = "name";
  static const String email = "email";
  static const String firstTime = "firstTime";
  static const String selectedLangId = "languageType";

  static Future<String> readString(String key) async {
    return (await box.read(key) ?? '');
  }

  static Future<bool> readBool(String key) async {
    return (await box.read(key) ?? false);
  }

  static Future<bool> read(String key) async {
    return (await box.read(key) ?? false);
  }

  static Future<int> readInt(String key) async {
    return (await box.read(key) ?? (-1));
  }

  static Future<double> readDouble(String key) async {
    return (await box.read(key) ?? (-1.0));
  }

  static write(String key, value) {
    box.write(key, value);
  }

  static readObj(String key) {
    var data = box.read(key);
    return data != null ? json.decode(data) : null;
  }

  static writeObj(String key, value) {
    box.write(key, json.encode(value));
  }

  static erase() async {
    await box.erase();
  }
}
