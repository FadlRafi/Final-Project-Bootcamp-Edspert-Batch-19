part of 'course_list_bloc.dart';

@immutable
sealed class CourseListEvent {}
class GetCourseListEvent extends CourseListEvent{
  final String majorName;
  GetCourseListEvent({required this.majorName});
}

class GetExerciseEvent extends CourseListEvent{
  final String courseId;

  GetExerciseEvent({required this.courseId});
}

class GetQuestionEvent extends CourseListEvent{
  final String exerciseId;

  GetQuestionEvent({required this.exerciseId});
}