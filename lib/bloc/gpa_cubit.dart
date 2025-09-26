import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpa/Data/dataHelper.dart';
import 'package:gpa/Screens/Components/cource_Item.dart';
part 'gpa_state.dart';

class GpaAppCubit extends Cubit<GpaAppState> {
  GpaAppCubit() : super(GpaInitial()) {
    loadSavedData();
  }

  static GpaAppCubit get(context) => BlocProvider.of(context);

  // Course data
  List<Course> courses = [];
  List<Widget> gpaItems = [];
  double gpa = 0.0;

  // Load saved data from SharedPreferences
  Future<void> loadSavedData() async {
    try {
      courses = DataHelper.getCourses();
      gpa = DataHelper.getGPA();

      // If no courses are saved, add one empty course item
      if (courses.isEmpty) {
        gpaItems = [const CourseItem(index: 0)];
      } else {
        // Create course items for each saved course
        gpaItems = List.generate(
          courses.length,
          (index) => CourseItem(
            initialName: courses[index].name,
            initialGrade: courses[index].grade.toString(),
            initialUnits: courses[index].units.toString(),
            index: index,
          ),
        );
      }
      emit(GpaDataLoaded());
    } catch (e) {
      // If there's an error, start with a clean state
      courses = [];
      gpaItems = [const CourseItem(index: 0)];
      gpa = 0.0;
      emit(GpaDataLoaded());
    }
  }

  // Update course data
  void updateCourse(int index, String name, double grade, int units) {
    try {
      if (index >= courses.length) {
        courses.add(Course(name: name, grade: grade, units: units));
      } else {
        courses[index] = Course(name: name, grade: grade, units: units);
      }
      saveCourses();
      emit(GpaCourseUpdated());
    } catch (e) {
      // Handle error
      emit(GpaError());
    }
  }

  // Save courses to SharedPreferences
  Future<void> saveCourses() async {
    try {
      await DataHelper.saveCourses(courses);
      emit(GpaDataSaved());
    } catch (e) {
      emit(GpaError());
    }
  }

  // Add a new course item
  void addItem() {
    try {
      int newIndex = gpaItems.length;
      gpaItems.add(CourseItem(index: newIndex));
      // Add an empty course to maintain consistency
      courses.add(Course(name: '', grade: 0.0, units: 0));
      saveCourses();
      emit(GpaAddItem());
    } catch (e) {
      emit(GpaError());
    }
  }

  // Remove the last course item
  void removeItem() {
    try {
      if (gpaItems.length == 1) {
        return;
      } else {
        gpaItems.removeLast();
        if (courses.isNotEmpty && courses.length >= gpaItems.length) {
          courses.removeLast();
          saveCourses();
        }
      }
      emit(GpaRemoveItem());
    } catch (e) {
      emit(GpaError());
    }
  }

  // Calculate GPA
  void calculateGPA() {
    try {
      gpa = DataHelper.calculateGPA(courses);
      DataHelper.saveGPA(gpa);
      emit(GpaCalculated());
    } catch (e) {
      emit(GpaError());
    }
  }

  // Clear all courses
  void clearAll() {
    try {
      courses.clear();
      gpaItems = [const CourseItem(index: 0)];
      gpa = 0.0;
      saveCourses();
      DataHelper.saveGPA(0.0);
      emit(GpaCleared());
    } catch (e) {
      emit(GpaError());
    }
  }
}
