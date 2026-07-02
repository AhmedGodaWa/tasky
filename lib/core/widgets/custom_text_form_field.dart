import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.maxLines,
    this.validator,
    this.textInputAction,
    this.borderSide = BorderSide.none,
  });

  final String title;
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  /* This means exactly: 
      final String? Function(String?)? validator;
  */
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: borderSide,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Color(0xFFFFFCFC), fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextFormField(
          maxLines: maxLines,
          textInputAction: textInputAction,

          validator: validator,
          controller: controller,
          cursorColor: const Color(0xFFFFFCFC),
          style: const TextStyle(color: Color(0xFFFFFCFC)),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
            filled: true,
            fillColor: const Color(0xFF282828),
            border: outlineBorder,
            enabledBorder: outlineBorder,
            focusedBorder: outlineBorder,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
