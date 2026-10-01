import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final label;
  final bool isSelected;
  final VoidCallback onTap;
  const Category(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
