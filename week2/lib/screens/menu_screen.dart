import 'package:flutter/material.dart';
import '../widget/category_chip.dart';
import '../widget/menu_item_card.dart';
import '../widget/cart_bar.dart';

// Simple data class to hold menu item display data
class MenuItemData {
  final String name;
  final String description;
  final double price;
  final bool isAvailable;
  final String category;
  final String? imageUrl;
  final int quantity;

  const MenuItemData({
    required this.name,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.category,
    this.imageUrl,
    this.quantity = 0,
  });
}

class MenuScreen extends StatelessWidget {
  final String restaurantName;
  final String tableName;
  final String selectedCategory;
  final List<MenuItemData> items;
  final void Function(String category) onCategorySelected;
  final void Function(MenuItemData item) onAdd;
  final void Function(MenuItemData item) onRemove;
  final VoidCallback onViewOrder;
  final int selectedIndex; // bottom nav

  const MenuScreen({
    super.key,
    required this.restaurantName,
    required this.tableName,
    required this.selectedCategory,
    required this.items,
    required this.onCategorySelected,
    required this.onAdd,
    required this.onRemove,
    required this.onViewOrder,
    this.selectedIndex = 0,
  });

  List<MenuItemData> get _filtered {
    if (selectedCategory == 'All') return items;
    return items
        .where((i) => i.category == selectedCategory)
        .toList();
  }

  int get _cartCount =>
      items.fold(0, (sum, i) => sum + i.quantity);

  double get _cartTotal =>
      items.fold(0.0, (sum, i) => sum + (i.price * i.quantity));

  @override
  Widget build(BuildContext context) {
    const categories = ['All', 'Food', 'Drinks'];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        title: Text(
          'Menu - $restaurantName',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Menu" label
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Active dine-in banner
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEF8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ACTIVE DINE-IN',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black45,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tableName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Category chips
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: categories
                          .map(
                            (c) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CategoryChip(
                                label: c,
                                isSelected: selectedCategory == c,
                                onTap: () => onCategorySelected(c),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Menu item list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final item = _filtered[index];
                        return MenuItemCard(
                          name: item.name,
                          description: item.description,
                          price: item.price,
                          isAvailable: item.isAvailable,
                          quantity: item.quantity,
                          imageUrl: item.imageUrl,
                          onAdd: () => onAdd(item),
                          onRemove: () => onRemove(item),
                        );
                      },
                    ),
                  ),

                  // Cart bar (only show when items in cart)
                  if (_cartCount > 0)
                    CartBar(
                      itemCount: _cartCount,
                      totalPrice: _cartTotal,
                      onViewOrder: onViewOrder,
                    ),
                ],
              ),
            ),
          ),

          // Bottom navigation
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.restaurant_menu,
                  label: 'Menu',
                  isActive: selectedIndex == 0,
                ),
                _NavItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'Orders',
                  isActive: selectedIndex == 1,
                ),
                _NavItem(
                  icon: Icons.money_outlined,
                  label: 'Bill',
                  isActive: selectedIndex == 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF8B3A1A) : Colors.black38;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
