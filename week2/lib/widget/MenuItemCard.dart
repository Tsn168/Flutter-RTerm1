import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';

class Menuitemcard extends StatelessWidget {
  final MenuItem menuItem;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const Menuitemcard(
      {super.key,
      required this.menuItem,
      required this.quantity,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
