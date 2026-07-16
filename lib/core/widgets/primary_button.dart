import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: icon == null
          ? ElevatedButton(onPressed: onPressed, child: Text(text))
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(text),
            ),
    );
  }
}
