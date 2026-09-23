import 'package:flutter/material.dart';

class CartBar extends StatelessWidget {
  final int itemCount;
  final double totalPrice;
  final VoidCallback onViewOrder;

  const CartBar({
    super.key,
    required this.itemCount,
    required this.totalPrice,
    required this.onViewOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2B3B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Cart icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF8B3A1A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.receipt_long, color: Colors.white, size: 22),
          ),

          const SizedBox(width: 12),

          // Item count + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$itemCount item${itemCount == 1 ? '' : 's'} selected',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // View Order button
          ElevatedButton(
            onPressed: onViewOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B3A1A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'View Order',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
