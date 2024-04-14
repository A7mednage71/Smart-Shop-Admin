import 'package:flutter/material.dart';

class CustomTextButtonImageOption extends StatelessWidget {
  const CustomTextButtonImageOption({
    super.key,
    this.onPressed,
    required this.text,
    required this.icon,
    this.color,
  });

  final void Function()? onPressed;
  final String text;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: 30,
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
