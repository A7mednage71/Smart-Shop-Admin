import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    this.onTap,
    required this.icon,
    this.radius = 10,
    this.value = 10,
  });
  final void Function()? onTap;
  final Icon icon;
  final double radius;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(value),
          child: icon,
        ),
      ),
    );
  }
}
