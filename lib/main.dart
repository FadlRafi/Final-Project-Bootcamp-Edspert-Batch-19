import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/bloc_observer.dart';
import 'package:learn_apps/firebase_options.dart';
import 'package:learn_apps/src/data/datasource/auth_remote_datasource.dart';
import 'package:learn_apps/src/data/datasource/banner_remote_datasource.dart';
import 'package:learn_apps/src/data/datasource/course_remote_datasource.dart';
import 'package:learn_apps/src/data/datasource/profile_remote_datasource.dart';
import 'package:learn_apps/src/data/repository/auth_repository_impl.dart';
import 'package:learn_apps/src/data/repository/banner_repository_impl.dart';
import 'package:learn_apps/src/data/repository/course_repository_impl.dart';
import 'package:learn_apps/src/data/repository/profile_repository_impl.dart';
import 'package:learn_apps/src/domain/repository/course_repository.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/is_signed_in_google_usecase.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/is_user_registered_usecase.dart';
import 'package:learn_apps/src/domain/usecase/auth_usecase/sign_in_with_google.dart';
import 'package:learn_apps/src/domain/usecase/banner/get_banner_usecase.dart';
import 'package:learn_apps/src/domain/usecase/course/get_course_usecase.dart';
import 'package:learn_apps/src/domain/usecase/course/get_exercise_usecase.dart';
import 'package:learn_apps/src/domain/usecase/course/get_question_usecase.dart';
import 'package:learn_apps/src/domain/usecase/profile/get_profile_usecase.dart';
import 'package:learn_apps/src/domain/usecase/profile/update_profile_usecase.dart';
import 'package:learn_apps/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/banner_bloc/banner_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/course_list_bloc/course_list_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/nav_cubit/nav_cubit.dart';
import 'package:learn_apps/src/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/auth/login_screen.dart';
import 'package:learn_apps/src/presentation/screens/auth/registration_form_screen.dart';
import 'package:learn_apps/src/presentation/screens/auth/splash_screen.dart';
import 'package:learn_apps/src/presentation/screens/course/course_list/course_list_screen.dart';
import 'package:learn_apps/src/presentation/screens/course/exercise_list/exercise_screen.dart';
import 'package:learn_apps/src/presentation/screens/course/question_list/question_screen.dart';
import 'package:learn_apps/src/presentation/screens/home/home_nav_screen.dart';
import 'package:learn_apps/src/presentation/screens/profile/edit_profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            CourseRepository repo = CourseRepositoryImpl(
                courseRemoteDatasource: CourseRemoteDatasource(client: Dio()));
            return CourseListBloc(
              GetCourseUsecase(repository: repo),
              GetExerciseUsecase(repository: repo),
              GetQuestionUsecase(repository: repo),
            );
          },
        ),
        BlocProvider(
          create: (context) => BannerBloc(GetBannerUsecase(
              repository: BannerRepositoryImpl(
                  remoteDatasource: BannerRemoteDatasource()))),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
              IsSignedInWithGoogleUsecase(
                  repository: AuthRepositoryImpl(
                      remoteDatasource: AuthRemoteDatasource(client: Dio()))),
              IsUserRegisteredUsecase(
                  repository: AuthRepositoryImpl(
                      remoteDatasource: AuthRemoteDatasource(client: Dio()))),
              SignInWithGoogleUsecase(
                  repository: AuthRepositoryImpl(
                      remoteDatasource: AuthRemoteDatasource(client: Dio())))),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
              GetProfileUsecase(
                  repository: ProfileRepositoryImpl(
                      authRemoteDatasource: AuthRemoteDatasource(client: Dio()),
                      profileRemoteDatasource:
                          ProfileRemoteDatasource(client: Dio()))),
              UpdateProfileUsecase(
                  repository: ProfileRepositoryImpl(
                      authRemoteDatasource: AuthRemoteDatasource(client: Dio()),
                      profileRemoteDatasource:
                          ProfileRemoteDatasource(client: Dio())))),
        ),
        BlocProvider(
          create: (context) => HomeNavCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: true // untuk menyatukan antara appbar dengan body
            ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.loginScreen: (context) => const LoginScreen(),
          Routes.homeScreen: (context) =>  HomeNavigationScreen(),
          Routes.registrationFormScreen: (context) =>
              const RegistrationFormScreen(),
          Routes.editProfile: (context) => const EditProfileScreen(),
          Routes.courseListScren: (context) => const CourseListScreen(),
          Routes.exerciseScreen: (context) => const ExerciseScreen(),
          Routes.questionScreen: (context) => const QuestionScreen()
        },
      ),
    );
  }
}
