import 'dart:convert';

import 'package:android_flutter_app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];
/// 全局变量共享
class Global {
  static bool isDebug = true;
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  static List<MaterialColor> get themes => themes;
  // 颜色
  static List<Color> colors = [
    Color(0xffe54d42),
    Color(0xfff37b1d),
    Color(0xfffbbd08),
    Color(0xff8dc63f),
    Color(0xff39b54a),
    Color(0xff1cbbb4),
    Color(0xff0081ff),
    Color(0xff6739b6),
    Color(0xff9c26b0),
    Color(0xffe03997),
    Color(0xffa5673f)
  ];
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {}
    }
  }

  static saveProfile() => _prefs.setString("profile", jsonEncode(profile.toJson()));
}
