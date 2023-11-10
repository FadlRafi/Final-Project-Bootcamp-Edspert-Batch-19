import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:learn_apps/src/data/model/update_profile_request_model.dart';

class ProfileRemoteDatasource {
  final Dio client;

  const ProfileRemoteDatasource({required this.client});

  Future<bool> updateProfile({
    required String fullName,
    required String email,
    required String schoolName,
    required String schoolLevel,
    required String schoolGrade,
    required String gender,
    String? photoUrl,
  }) async {
    try {
      const String url = 'https://edspert.widyaedu.com/users/update';

      final result = await client.post(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
        data: FormData.fromMap(
          UpdateProfileRequestModel(
            fullName: fullName,
            email: email,
            schoolName: schoolName,
            schoolLevel: schoolLevel,
            schoolGrade: schoolGrade,
            gender: gender,
            photoUrl: photoUrl,
          ).toMap(),
        ),
      );

      if (result.data['message'] == "update sukses") {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      log(error.toString(), stackTrace: stacktrace);
      return false;
    }
  }
}