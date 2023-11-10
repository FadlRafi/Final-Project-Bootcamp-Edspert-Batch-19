import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_apps/src/domain/entity/user_response_entity.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameTextEditingController = TextEditingController();

  XFile? _selectedImageFile;

  UserDataEntity? profile;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        profile = ModalRoute.of(context)?.settings.arguments as UserDataEntity;
        _nameTextEditingController.text = profile?.userName ?? '';
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
                setState(() {
                  _selectedImageFile = file;
                });
              },
              child: _selectedImageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.file(
                        File(_selectedImageFile!.path),
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        profile?.userFoto ?? '',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                        errorBuilder: (context, o, s) {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama Lengkap',
              ),
              controller: _nameTextEditingController,
            ),
            TextField(
              controller: TextEditingController(text: profile?.userEmail ?? ''),
              enabled: false,
            ),
            ElevatedButton(
              onPressed: () async {
                String? photoUrl;
                if (_selectedImageFile != null) {
                  final profilePictureRef = FirebaseStorage.instance.ref(
                    'image/${profile?.userEmail}.jpg',
                  );
                  try {
                    // Upload raw data.
                    await profilePictureRef.putFile(File(_selectedImageFile!.path));
                    photoUrl = await profilePictureRef.getDownloadURL();
                  } on FirebaseException catch (e) {
                    print('Err upload $e');
                    // ...
                  }
                }

                print('url: ${photoUrl}');

                // context.read<ProfileBloc>().add(UpdateProfileEvent(
                //       fullName: _nameTextEditingController.text,
                //       email: profile?.userEmail ?? '',
                //       schoolName: schoolName,
                //       schoolLevel: schoolLevel,
                //       schoolGrade: schoolGrade,
                //       gender: gender,
                //     ));
              },
              child: Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}