import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<bool> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var pass = prefs.getString("pass");
    return email != null && pass != null && email != "" && pass != "";
  }

  static saveLogin(String email, String pass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("pass", pass);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }

  static Future<String> getPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("pass") ?? "";
  }

  static clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
