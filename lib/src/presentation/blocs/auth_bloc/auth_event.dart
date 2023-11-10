part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class SignInWithGoogleEvent extends AuthEvent {}

class CheckIsUserRegisteredEvent extends AuthEvent {}

class CheckIsSignedInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}