part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}
class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String fullName;
  final String email;
  final String schoolName;
  final String schoolLevel;
  final String schoolGrade;
  final String gender;
  final String? photoUrl;

  UpdateProfileEvent({
    required this.fullName,
    required this.email,
    required this.schoolName,
    required this.schoolLevel,
    required this.schoolGrade,
    required this.gender,
    this.photoUrl,
  });
}