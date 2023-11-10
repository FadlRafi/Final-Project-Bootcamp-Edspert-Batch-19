import 'package:learn_apps/src/domain/repository/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;

  const UpdateProfileUsecase({required this.repository});

  Future<bool> call({
    required String fullName,
    required String email,
    required String schoolName,
    required String schoolLevel,
    required String schoolGrade,
    required String gender,
    String? photoUrl,
  }) async =>
      await repository.updateProfile(
        fullName: fullName,
        email: email,
        schoolName: schoolName,
        schoolLevel: schoolLevel,
        schoolGrade: schoolGrade,
        gender: gender,
        photoUrl: photoUrl,
      );
}