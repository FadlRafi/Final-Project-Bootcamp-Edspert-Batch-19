import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_apps/src/domain/entity/user_response_entity.dart';
import 'package:learn_apps/src/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is GetProfileState,
      builder: (context, state) {
        String? name;
        String? school;
        UserDataEntity? profile;
        if (state is GetProfileState) {
          name = state.profile?.userName;
          school = state.profile?.userAsalSekolah;
          profile = state.profile;
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Akun Saya',
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  if (profile != null) {
                    Navigator.pushNamed(
                      context,
                      Routes.editProfile,
                      arguments: profile,
                    );
                  }
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              Text('$name'),
              Text('$school'),
              ElevatedButton(
                onPressed: () async {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  }
                },
                child: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }
}