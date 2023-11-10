import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_apps/src/domain/repository/auth_repository.dart';

class SignInWithGoogleUsecase {
  final AuthRepository repository;

  const SignInWithGoogleUsecase({required this.repository});

  Future<User?> call() async => await repository.signInWithGoogle();
}