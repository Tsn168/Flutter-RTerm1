import 'package:flutter/material.dart';

class CartBar extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  final VoidCallback viewOrder;
  const CartBar(
      {super.key,
      required this.itemCount,
      required this.totalPrice,
      required this.viewOrder});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
