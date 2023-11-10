part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class SignInWithGoogleState extends AuthState {
  final User? result;
  final bool isLoading;

  SignInWithGoogleState({
    required this.result,
    required this.isLoading,
  });
}
class CheckIsUserRegisteredState extends AuthState {
  final bool isRegistered;
  final bool isLoading;

  CheckIsUserRegisteredState({
    required this.isRegistered,
    required this.isLoading,
  });
}
class CheckIsUserSignedInWithGoogleState extends AuthState {
  final bool isSignedIn;
  final bool isLoading;
  final String? errorMessage;

  CheckIsUserSignedInWithGoogleState({
    required this.isSignedIn,
    required this.isLoading,
    this.errorMessage,
  });
}