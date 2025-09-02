import 'package:shared_preferences/shared_preferences.dart';

class DataHelper {
  //kays---------------------------
  static var name = 'course name';
  static var grade = 'grade';
  static var unites = 'unites';

  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static setCoursename(String courseName) async {
    await preferences!.setString(name, courseName);
  }

  getCourseName() {
    preferences!.getString(name);
  }

  static setGrade(String gradeValue) async {
    await preferences!.setString(grade, gradeValue);
  }

  getGrade() {
    preferences!.getString(grade);
  }

  static setUnits(String unitesValue) async {
    await preferences!.setString(unites, unitesValue);
  }

  getUnits() {
    preferences!.getString(unites);
  }

  getData() async {}
}
