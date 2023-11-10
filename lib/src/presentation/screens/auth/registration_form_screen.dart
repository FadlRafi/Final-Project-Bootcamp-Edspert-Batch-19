import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:learn_apps/src/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:learn_apps/src/presentation/router/routes.dart';
import 'package:learn_apps/src/presentation/screens/auth/widgets/input_field_widget.dart';
import 'package:learn_apps/src/presentation/screens/auth/widgets/select_gender_widget.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController namaSekolahTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileState) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text(
                'Yuk isi data diri',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputFieldWidget(
                      titleText: 'Email',
                      hintText: email.toString(),
                      enabled: false,
                      controller: TextEditingController(text: ''),
                    ),
                    const SizedBox(height: 15),
                    InputFieldWidget(
                      titleText: 'Nama Lengkap',
                      hintText: 'contoh: Rahmat Jaya',
                      controller: fullNameTextController,
                    ),

                    const SizedBox(height: 15),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    SelectGenderWidget(
                      gender: '',
                      onSelectGender: (value) {},
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField(
                      value: '10',
                      decoration: InputDecoration(
                          hintText: 'Pilih Kelas',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true),
                      items: const [
                        DropdownMenuItem(value: '10', child: Text('Kelas 10')),
                        DropdownMenuItem(value: '11', child: Text('Kelas 11')),
                        DropdownMenuItem(value: '12', child: Text('Kelas 12')),
                      ],
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 15),
                    InputFieldWidget(
                      titleText: 'Nama Sekolah',
                      hintText: 'Sekolah...',
                      controller: namaSekolahTextController,
                    ),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ProfileBloc>().add(UpdateProfileEvent(
                              fullName: fullNameTextController.text,
                              email: email.toString(),
                              schoolName: 'Sekolah Menengah',
                              schoolLevel: '12',
                              schoolGrade: 'A',
                              gender: 'Laki-Laki'));

                          Navigator.pushReplacementNamed(
                              context, Routes.homeScreen);
                        },
                        style: const ButtonStyle(
                            fixedSize: MaterialStatePropertyAll(
                              Size(305, 65),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFF3A7FD5))),
                        child: const Text(
                          'DAFTAR',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
