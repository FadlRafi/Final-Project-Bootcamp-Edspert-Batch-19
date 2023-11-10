import 'package:learn_apps/src/domain/repository/auth_repository.dart';

class IsSignedInWithGoogleUsecase {
  final AuthRepository repository;

  const IsSignedInWithGoogleUsecase({required this.repository});

  bool call() => repository.isSignedInWithGoogle();
}