import 'package:learn_apps/src/domain/entity/user_response_entity.dart';
import 'package:learn_apps/src/domain/repository/profile_repository.dart';

class GetProfileUsecase {
  final ProfileRepository repository;

  const GetProfileUsecase({required this.repository});

  Future<UserDataEntity?> call() async => await repository.getProfile();
}