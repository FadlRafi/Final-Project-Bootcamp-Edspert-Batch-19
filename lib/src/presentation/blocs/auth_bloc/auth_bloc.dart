import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/is_signed_in_google_usecase.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/is_user_registered_usecase.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/sign_in_with_google.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final IsUserRegisteredUsecase isUserRegisteredUsecase;
  final IsSignedInWithGoogleUsecase isSignedInWithGoogleUsecase;

  AuthBloc(
    this.isSignedInWithGoogleUsecase,
    this.isUserRegisteredUsecase,
    this.signInWithGoogleUsecase,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInWithGoogleEvent) {
        emit(SignInWithGoogleState(result: null, isLoading: true));

        final User? user = await signInWithGoogleUsecase();

        emit(SignInWithGoogleState(
          result: user,
          isLoading: false,
        ));
      }
      if (event is CheckIsSignedInWithGoogleEvent) {
        emit(CheckIsUserSignedInWithGoogleState(
          isSignedIn: false,
          isLoading: true,
        ));

        bool isSignedIn = isSignedInWithGoogleUsecase();

        if (isSignedIn) {
          emit(CheckIsUserSignedInWithGoogleState(
            isSignedIn: isSignedIn,
            isLoading: false,
          ));
        } else {
          emit(CheckIsUserSignedInWithGoogleState(
            isSignedIn: isSignedIn,
            isLoading: false,
            errorMessage: 'User is not signed in.',
          ));
        }
      }

      if (event is CheckIsUserRegisteredEvent) {
        emit(CheckIsUserRegisteredState(
          isRegistered: false,
          isLoading: true,
        ));

        bool isRegistered = await isUserRegisteredUsecase();

        emit(CheckIsUserRegisteredState(
          isRegistered: isRegistered,
          isLoading: false,
        ));
      }
    });
  }
  String getCurrentSignedInEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '';
  }
}
