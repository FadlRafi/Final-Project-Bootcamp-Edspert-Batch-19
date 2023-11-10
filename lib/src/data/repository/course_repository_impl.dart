import 'package:learn_apps/src/data/datasource/course_remote_datasource.dart';
import 'package:learn_apps/src/data/model/course_list_response_model.dart';
import 'package:learn_apps/src/data/model/exercises_response_model.dart';
import 'package:learn_apps/src/data/model/question_response_model.dart';
import 'package:learn_apps/src/domain/entity/course_list_response_entity.dart';
import 'package:learn_apps/src/domain/entity/exercise_response_entity.dart';
import 'package:learn_apps/src/domain/entity/question_response_entity.dart';
import 'package:learn_apps/src/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDatasource courseRemoteDatasource;
  CourseRepositoryImpl({required this.courseRemoteDatasource});

  @override
  Future<List<CourseDataEntity>?> getCourse(String majorName) async {
    final response = await courseRemoteDatasource.getCourse(majorName, '');
    if (response.data == null) {
      return null;
    }
    final data = CourseListResponseEntity(
      status: response.status ?? -1,
      message: response.message ?? '',
      data: List<CourseData>.from(response.data ?? [])
          .map(
            (e) => CourseDataEntity(
                courseId: e.courseId ?? '',
                majorName: e.majorName ?? '',
                courseCategory: e.courseCategory ?? '',
                courseName: e.courseName ?? '',
                jumlahDone: e.jumlahDone ?? 0,
                jumlahMateri: e.jumlahMateri ?? 0,
                progress: e.progress ?? 0,
                urlCover: e.urlCover ?? ''),
          )
          .toList(),
    );
    return data.data;
  }

  @override
  Future<List<ExerciseDataEntity>?> getExercise(String courseId) async {
    final response =
        await courseRemoteDatasource.getExercises(courseId: courseId);

    if (response.data == null) {
      return null;
    }
    final data = ExercisesResponseEntity(
        status: response.status ?? -1,
        message: response.message ?? '',
        data: List<ExerciseData>.from(response.data ?? [])
            .map((e) => ExerciseDataEntity(
                exerciseId: e.exerciseId ?? '',
                exerciseTitle: e.exerciseTitle ?? '',
                accessType: e.accessType ?? '',
                icon: e.icon ?? '',
                exerciseUserStatus: e.exerciseUserStatus ?? '',
                jumlahDone: e.jumlahDone ?? 0,
                jumlahSoal: e.jumlahSoal ?? ''))
            .toList());
    return data.data;
  }

  @override
  Future<List<QuestionDataEntity>?> getQuestion(String exerciseId) async {
    final response =
        await courseRemoteDatasource.getQuestion(exerciseId: exerciseId);
    if (response.data == null) {
      return null;
    }
    final data = QuestionResponseEntity(
        status: response.status ?? -1,
        message: response.message ?? '',
        data: List<QuestionData>.from(response.data ?? [])
            .map((e) => QuestionDataEntity(
                exerciseIdFk: e.exerciseIdFk ?? '',
                bankQuestionId: e.bankQuestionId ?? '',
                questionTitle: e.questionTitle ?? '',
                questionTitleImg: e.questionTitleImg,
                optionA: e.optionA ?? '',
                optionAImg: e.optionAImg,
                optionB: e.optionB ?? '',
                optionBImg: e.optionBImg,
                optionC: e.optionC ?? '',
                optionCImg: e.optionCImg,
                optionD: e.optionD ?? '',
                optionDImg: e.optionDImg,
                optionE: e.optionE ?? '',
                optionEImg: e.optionEImg,
                studentAnswer: e.studentAnswer ?? ''))
            .toList());
    return data.data;
  }
}
