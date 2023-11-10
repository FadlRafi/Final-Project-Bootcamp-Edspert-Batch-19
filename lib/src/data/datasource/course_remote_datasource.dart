import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:learn_apps/src/data/model/course_list_response_model.dart';
import 'package:learn_apps/src/data/model/exercises_response_model.dart';
import 'package:learn_apps/src/data/model/question_response_model.dart';
import 'package:learn_apps/src/value/path.dart';

class CourseRemoteDatasource {
  final Dio client;
  CourseRemoteDatasource({required this.client});
  Future<CourseResponse> getCourse(String majorName, String email) async {
    try {
      final url = '${LearningPath.baseUrl}${LearningPath.coursePath}';
      final result = await client.get(url,
          options: Options(
            headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
          ),
          queryParameters: {
            'major_name': majorName,
            'user_email': 'testerngbayu@gmail.com'
          });
      final courseResponse = CourseResponse.fromJson(result.data);

      return courseResponse;
    } catch (e, stacktrace) {
      log(e.toString(), stackTrace: stacktrace, error: e);
      rethrow;
    }
  }

  Future<ExercisesResponses> getExercises({required String courseId}) async {
    try {
      final url = '${LearningPath.baseUrl}${LearningPath.exerciseList}';
      final result = await client.get(url,
          options: Options(
              headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'}),
          queryParameters: {
            'course_id': courseId,
            'user_email': 'testerngbayu@gmail.com'
          });

      final exerciseResponses = ExercisesResponses.fromJson(result.data);
      log('Exercise Response = ${json.encode(result.data)}');
      return exerciseResponses;
    } catch (e, stackrace) {
      log(e.toString(), stackTrace: stackrace, error: e);
      rethrow;
    }
  }

  Future<QuestionResponse> getQuestion({required String exerciseId}) async {
    try {
      final url = 'https://edspert.widyaedu.com/exercise/kerjakan';
      final payload = FormData.fromMap({
        'exercise_id': exerciseId,
        'user_email': 'testerngbayu@gmail.com'
      });
      final result = await client.post(url,
          options: Options(
            headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
          ),
          data: payload);
      final questionResponse = QuestionResponse.fromJson(result.data);
      log('Exercise Response = ${json.encode(result.data)}');
      return questionResponse;
    } catch (e, stackrace) {
      log(e.toString(), stackTrace: stackrace, error: e);
      rethrow;
    }
  }
}
