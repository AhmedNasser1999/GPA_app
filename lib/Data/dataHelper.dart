import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Course {
  String name;
  double grade;
  int units;

  Course({required this.name, required this.grade, required this.units});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'grade': grade,
      'units': units,
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'] ?? '',
      grade: (json['grade'] is int) ? (json['grade'] as int).toDouble() : json['grade'] ?? 0.0,
      units: json['units'] ?? 0,
    );
  }
}

class DataHelper {
  //keys---------------------------
  static const String coursesKey = 'courses';
  static const String gpaKey = 'gpa';

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  static SharedPreferences get preferences {
    if (_preferences == null) {
      throw Exception('SharedPreferences not initialized. Call DataHelper.init() first.');
    }
    return _preferences!;
  }

  // Save list of courses
  static Future<bool> saveCourses(List<Course> courses) async {
    try {
      List<String> coursesJson = courses.map((course) => jsonEncode(course.toJson())).toList();
      return await preferences.setStringList(coursesKey, coursesJson);
    } catch (e) {
      print('Error saving courses: $e');
      return false;
    }
  }

  // Get list of courses
  static List<Course> getCourses() {
    try {
      List<String>? coursesJson = preferences.getStringList(coursesKey);
      if (coursesJson == null || coursesJson.isEmpty) return [];
      
      return coursesJson.map((courseJson) {
        try {
          Map<String, dynamic> courseMap = jsonDecode(courseJson);
          return Course.fromJson(courseMap);
        } catch (e) {
          print('Error parsing course: $e');
          return Course(name: '', grade: 0.0, units: 0);
        }
      }).toList();
    } catch (e) {
      print('Error getting courses: $e');
      return [];
    }
  }

  // Save GPA
  static Future<bool> saveGPA(double gpa) async {
    try {
      return await preferences.setDouble(gpaKey, gpa);
    } catch (e) {
      print('Error saving GPA: $e');
      return false;
    }
  }

  // Get GPA
  static double getGPA() {
    try {
      return preferences.getDouble(gpaKey) ?? 0.0;
    } catch (e) {
      print('Error getting GPA: $e');
      return 0.0;
    }
  }

  // Calculate GPA
  static double calculateGPA(List<Course> courses) {
    if (courses.isEmpty) return 0.0;
    
    double totalGradePoints = 0;
    int totalUnits = 0;
    
    for (var course in courses) {
      if (course.units > 0) {
        totalGradePoints += course.grade * course.units;
        totalUnits += course.units;
      }
    }
    
    return totalUnits > 0 ? totalGradePoints / totalUnits : 0.0;
  }
  
  // Clear all data
  static Future<bool> clearAll() async {
    try {
      await preferences.remove(coursesKey);
      await preferences.remove(gpaKey);
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }
}
