import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class AppNameWidget extends StatelessWidget {
  const AppNameWidget({super.key, this.size = 20, required this.name});
  final double size;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: Text(
        name,
        style: TextStyle(fontSize: size),
      ),
    );
  }
}
