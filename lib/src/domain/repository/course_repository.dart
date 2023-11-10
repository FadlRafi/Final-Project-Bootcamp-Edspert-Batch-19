import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/domain/entity/question_response_entity.dart';

abstract class CourseRepository{

  Future<List<CourseDataEntity>?> getCourse(String majorName);
  Future<List<ExerciseDataEntity>?> getExercise(String courseId);
  Future<List<QuestionDataEntity>?> getQuestion(String exerciseId);
}