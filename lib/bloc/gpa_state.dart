part of 'gpa_cubit.dart';

@immutable
abstract class GpaAppState {}

class GpaInitial extends GpaAppState {}

class GpaAddItem extends GpaAppState {}

class GpaRemoveItem extends GpaAppState {}

class ChangeCourseNameValue extends GpaAppState {}

class ChangeGradeValue extends GpaAppState {}

class ChangeUintesValue extends GpaAppState {}
