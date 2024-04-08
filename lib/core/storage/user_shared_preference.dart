import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreference {
  static late SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  static setAccessToken(String accessToken) async {
    await _preferences.setString("accessTokenKey", accessToken);
  }
  static String? getAccessToken() {
    return _preferences.getString("accessTokenKey");
  }
  static Future<bool> removeAccessToken() async {
    return await _preferences.remove("accessTokenKey");
  }
  static Future clear() async {
    bool success = false;
    success = await removeAccessToken();
    if (success) {
      debugPrint("UserSharedPreferences is clear now!");
    }
    return success;
  }
}