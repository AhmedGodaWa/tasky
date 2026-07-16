import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.maxLines,
    this.validator,
    this.textInputAction,
  });

  final String title;
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          textInputAction: textInputAction,
          style: Theme.of(context).textTheme.bodyLarge,
          cursorColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCursor
              : AppColors.lightCursor,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
