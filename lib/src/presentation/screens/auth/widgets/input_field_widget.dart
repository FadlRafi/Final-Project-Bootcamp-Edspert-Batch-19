import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final String titleText;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  const InputFieldWidget({
    super.key,
    required this.titleText,
    required this.controller,
    required this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          onSubmitted: (String value) {
            
          },
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFD6D6D6))),
              fillColor: Colors.white,
              filled: true),
          // readOnly: !enabled,
        ),
      ],
    );
  }
}
