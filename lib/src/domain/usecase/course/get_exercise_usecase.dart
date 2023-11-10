import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/domain/repository/course_repository.dart';

class GetExerciseUsecase{
  final CourseRepository repository;

  GetExerciseUsecase({required this.repository});

  Future<List<ExerciseDataEntity>?> call(String courseId) async => await repository.getExercise(courseId);
}