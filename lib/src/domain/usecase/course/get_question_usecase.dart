import 'package:learn_apps/src/domain/entity/question_response_entity.dart';
import 'package:learn_apps/src/domain/repository/course_repository.dart';

class GetQuestionUsecase{
  final CourseRepository repository;

  GetQuestionUsecase({required this.repository});

  Future<List<QuestionDataEntity>?> call(String exerciseId) async => await repository.getQuestion(exerciseId);
}