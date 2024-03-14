import 'package:flutter/material.dart';
class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final String image, text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 80,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
