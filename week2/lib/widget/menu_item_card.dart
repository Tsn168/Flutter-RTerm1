import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final bool isAvailable;
  final int quantity;
  final String? imageUrl;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const MenuItemCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
                // Available / unavailable badge
                Positioned(
                  bottom: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isAvailable ? 'Available' : 'Unavailable',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                if (!isAvailable)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white54,
                      child: const Icon(
                        Icons.block,
                        color: Colors.black26,
                        size: 32,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Info + controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? Colors.black87 : Colors.black38,
                      ),
                    ),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isAvailable ? brown : Colors.black38,
                        decoration: isAvailable
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isAvailable ? Colors.black54 : Colors.black26,
                  ),
                ),

                const SizedBox(height: 10),

                // Qty + buttons
                if (!isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEF2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Out of Stock',
                      style: TextStyle(color: Colors.black38, fontSize: 13),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Qty label
                      Text(
                        'Qty: $quantity in cart',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                        ),
                      ),

                      // Controls
                      quantity == 0
                          ? GestureDetector(
                              onTap: onAdd,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: brown,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  '+ Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                          : Row(
                              children: [
                                _CircleButton(
                                  icon: Icons.remove,
                                  onTap: onRemove,
                                  filled: false,
                                ),
                                const SizedBox(width: 8),
                                _CircleButton(
                                  icon: Icons.add,
                                  onTap: onAdd,
                                  filled: true,
                                ),
                              ],
                            ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 90,
      height: 90,
      color: const Color(0xFFDDDDDD),
      child: const Icon(Icons.fastfood, color: Colors.white54, size: 32),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? const Color(0xFF8B3A1A) : const Color(0xFFEEEEF2),
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}
