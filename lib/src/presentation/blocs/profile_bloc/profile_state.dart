part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class GetProfileState extends ProfileState {
  final UserDataEntity? profile;

  GetProfileState({required this.profile});
}

class UpdateProfileState extends ProfileState {
  final bool result;

  UpdateProfileState({required this.result});
}
