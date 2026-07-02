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
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF15B86C),
      foregroundColor: const Color(0xFFFFFCFC),
    );

    final buttonText = Text(text, style: const TextStyle(fontSize: 14));

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: icon == null
          ? ElevatedButton(
              onPressed: onPressed,
              style: buttonStyle,
              child: buttonText,
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              style: buttonStyle,
              icon: Icon(icon),
              label: buttonText,
            ),
    );
  }
}
