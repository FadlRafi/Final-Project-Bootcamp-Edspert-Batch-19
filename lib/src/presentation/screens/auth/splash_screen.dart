import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/value/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        context.read<AuthBloc>().add(CheckIsSignedInWithGoogleEvent()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is CheckIsUserSignedInWithGoogleState) {
          if (!state.isLoading && state.isSignedIn) {
            context.read<AuthBloc>().add(CheckIsUserRegisteredEvent());
          } else {
            Navigator.pushReplacementNamed(context, Routes.loginScreen);
          }
        }
        if (state is CheckIsUserRegisteredState) {
          bool isRegistered = state.isRegistered;
          if (isRegistered) {
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          } else {
            Navigator.pushReplacementNamed(
                context, Routes.registrationFormScreen);
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.bluePrimary,
        body: Center(child: Image.asset('assets/logo (2).png')),
      ),
    );
  }
}
