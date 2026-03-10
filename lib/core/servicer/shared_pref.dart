import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  

  static Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  static Future<void> saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', path);
  }

  static Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  static Future<String?> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('image');
  }
}