import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';

class Menuitemcard extends StatelessWidget {
  final MenuItem menuItem;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const Menuitemcard({
    super.key,
    required this.menuItem,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);
    final isAvailable = menuItem.isAvailable;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Available/Out of Stock badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColorFiltered(
                  colorFilter: isAvailable
                      ? const ColorFilter.mode(
                          Colors.transparent, BlendMode.multiply)
                      : const ColorFilter.matrix([
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0.2126, 0.7152, 0.0722, 0, 0,
                          0,      0,      0,      1, 0,
                        ]),
                  child: Image.network(
                    menuItem.image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey.shade200,
                      child: Icon(
                        isAvailable ? Icons.fastfood : Icons.block,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
              // Badge
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: isAvailable
                        ? Colors.white.withOpacity(0.85)
                        : Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isAvailable ? 'Available' : 'Sold Out',
                    style: TextStyle(
                      fontSize: 10,
                      color: isAvailable ? Colors.black87 : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Info + controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + Price row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        menuItem.itemName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      '\$${menuItem.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isAvailable
                            ? brown
                            : Colors.grey,
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
                  menuItem.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isAvailable ? Colors.black54 : Colors.grey,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),

                // Qty controls
                if (!isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Out of Stock',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                else if (quantity == 0)
                  // "+ Add" button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onAdd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: brown,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '+ Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  // Qty: N in cart  —  minus  plus
                  Row(
                    children: [
                      Text(
                        'Qty: $quantity in cart',
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54),
                      ),
                      const Spacer(),
                      // Minus
                      GestureDetector(
                        onTap: onRemove,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.remove,
                              size: 16, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Plus
                      GestureDetector(
                        onTap: onAdd,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: brown,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add,
                              size: 16, color: Colors.white),
                        ),
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
}
