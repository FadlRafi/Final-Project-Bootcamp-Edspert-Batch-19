part of 'course_list_bloc.dart';

@immutable
sealed class CourseListState {}

final class CourseListInitial extends CourseListState {}
final class CourseListLoading extends CourseListState{}
final class CourseListSucces extends CourseListState{
  final List<CourseDataEntity>? data;

  CourseListSucces(this.data);
}
final class CourseListFailed extends CourseListState{
  final String? message;
  CourseListFailed({this.message});
}

final class ExerciseLoading extends CourseListState{}
final class ExerciseSucces extends CourseListState{
  final List<ExerciseDataEntity>? data;

  ExerciseSucces(this.data);
}
final class ExerciseFailed extends CourseListState{
  final String? message;
  ExerciseFailed(this.message);
}

final class QuestionLoading extends CourseListState{}
final class QuestionSucces extends CourseListState{
  final List<QuestionDataEntity>? data;

  QuestionSucces(this.data);
}
final class QuestionFailed extends CourseListState{
  final String? message;
  QuestionFailed(this.message);
}
