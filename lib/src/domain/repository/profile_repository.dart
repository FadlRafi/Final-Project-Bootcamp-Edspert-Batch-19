import '../entity/user_response_entity.dart';

abstract class ProfileRepository {
  Future<UserDataEntity?> getProfile();

  Future<bool> updateProfile({
    required String fullName,
    required String email,
    required String schoolName,
    required String schoolLevel,
    required String schoolGrade,
    required String gender,
    String? photoUrl,
  });
}