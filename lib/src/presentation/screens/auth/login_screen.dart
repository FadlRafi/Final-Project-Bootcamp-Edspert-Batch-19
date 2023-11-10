import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_apps/src/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/login.png'),
            Column(
              children: [
                const Text(
                  'Selamat Datang',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Text(
                    'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan konsultasi Soal',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF6A7483)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignInWithGoogleState) {
                      if (!state.isLoading && state.result != null) {
                        //// Check is registered.
                        context
                            .read<AuthBloc>()
                            .add(CheckIsUserRegisteredEvent());
                      } else {
                        print('Login cancelled!');
                      }
                    }

                    if (state is CheckIsUserRegisteredState) {
                      bool isRegistered = state.isRegistered;

                      if (isRegistered) {
                        Navigator.pushReplacementNamed(
                            context, Routes.homeScreen);
                      } else {
                        Navigator.pushReplacementNamed(
                            context, Routes.registrationFormScreen);
                      }
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(SignInWithGoogleEvent());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      elevation: const MaterialStatePropertyAll(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/google_icon.png', height: 26),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Masuk dengan Google',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    elevation: const MaterialStatePropertyAll(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/apple-logo.png', height: 26),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Masuk dengan Apple ID',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
