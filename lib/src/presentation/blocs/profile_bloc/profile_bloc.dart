import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/domain/entity/user_response_entity.dart';
import 'package:learn_apps/src/domain/usecase/profile/get_profile_usecase.dart';
import 'package:learn_apps/src/domain/usecase/profile/update_profile_usecase.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;
  ProfileBloc(
    this.getProfileUsecase,
    this.updateProfileUsecase,
  ) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        final UserDataEntity? profile = await getProfileUsecase();
        print('getProfile: ${profile}');
        emit(GetProfileState(profile: profile));
      }

      if (event is UpdateProfileEvent) {
        final result = await updateProfileUsecase(
          email: event.email,
          fullName: event.fullName,
          gender: event.gender,
          schoolGrade: event.schoolGrade,
          schoolLevel: event.schoolLevel,
          schoolName: event.schoolName,
          photoUrl: event.photoUrl,
        );
        emit(UpdateProfileState(result: result));
      }
    });
  }
}
