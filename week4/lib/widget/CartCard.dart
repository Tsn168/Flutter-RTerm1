import 'package:flutter/material.dart';
import 'package:week4/model/cart.dart';

class CartCard extends StatelessWidget {
  final Cart cart;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  const CartCard({
    super.key,
    required this.cart,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
