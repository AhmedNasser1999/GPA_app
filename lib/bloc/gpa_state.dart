part of 'gpa_cubit.dart';

@immutable
abstract class GpaAppState {}

class GpaInitial extends GpaAppState {}

class GpaAddItem extends GpaAppState {}

class GpaRemoveItem extends GpaAppState {}

class GpaDataLoaded extends GpaAppState {}

class GpaCourseUpdated extends GpaAppState {}

class GpaDataSaved extends GpaAppState {}

class GpaCalculated extends GpaAppState {}

class GpaCleared extends GpaAppState {}

class GpaError extends GpaAppState {}
