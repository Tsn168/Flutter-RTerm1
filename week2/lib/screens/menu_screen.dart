import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';
import 'package:restaurant_management/widget/CartBar.dart';
import 'package:restaurant_management/widget/Category.dart';
import 'package:restaurant_management/widget/MenuItemCard.dart';
import 'order_review_screen.dart';

class MenuScreen extends StatefulWidget {
  final String tableName;

  const MenuScreen({super.key, required this.tableName});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'All';

  // Sample menu data matching Figma
  final List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      itemName: 'Fried Rice',
      price: 3.50,
      category: 'Food',
      isAvailable: true,
      image:
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400',
      description: 'Fried rice with chicken, egg and scallions',
    ),
    MenuItem(
      id: '2',
      itemName: 'Beef Noodle',
      price: 4.00,
      category: 'Food',
      isAvailable: true,
      image:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
      description: 'Slow-braised beef broth with tender noodles',
    ),
    MenuItem(
      id: '3',
      itemName: 'Spring Rolls',
      price: 2.50,
      category: 'Food',
      isAvailable: true,
      image:
          'https://images.unsplash.com/photo-1606791405792-1004f1718d0c?w=400',
      description: 'Crispy vegetable rolls with sweet chili dip',
    ),
    MenuItem(
      id: '4',
      itemName: 'Coke',
      price: 1.00,
      category: 'Drinks',
      isAvailable: false,
      image: 'https://images.unsplash.com/photo-1554866585-cd94860890b7?w=400',
      description: 'Chilled 330ml can with ice cup',
    ),
    MenuItem(
      id: '5',
      itemName: 'Orange Juice',
      price: 2.00,
      category: 'Drinks',
      isAvailable: true,
      image:
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400',
      description: 'Freshly squeezed orange juice',
    ),
  ];

  // Track quantity per item id
  final Map<String, int> quantities = {};

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void addItem(MenuItem item) {
    setState(() {
      quantities[item.id] = (quantities[item.id] ?? 0) + 1;
    });
  }

  void removeItem(MenuItem item) {
    setState(() {
      final current = quantities[item.id] ?? 0;
      if (current > 1) {
        quantities[item.id] = current - 1;
      } else {
        quantities.remove(item.id);
      }
    });
  }

  List<MenuItem> get filteredItems {
    if (selectedCategory == 'All') {
      return menuItems;
    }
    return menuItems
        .where((item) => item.category == selectedCategory)
        .toList();
  }

  int get totalItemCount {
    int total = 0;
    for (final qty in quantities.values) {
      total += qty;
    }
    return total;
  }

  double get totalPrice {
    double total = 0;
    for (final item in menuItems) {
      final qty = quantities[item.id] ?? 0;
      total += item.price * qty;
    }
    return total;
  }

  List<MenuItem> get cartItems {
    return menuItems.where((item) => (quantities[item.id] ?? 0) > 0).toList();
  }

  void goToOrderReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderReviewScreen(
          tableName: widget.tableName,
          cartItems: cartItems,
          quantities: Map.from(quantities),
        ),
      ),
    ).then((updatedQuantities) {
      if (updatedQuantities != null) {
        setState(() {
          quantities.clear();
          quantities.addAll(updatedQuantities);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);
    const categories = ['All', 'Food', 'Drinks'];
    final items = filteredItems;
    final hasCart = totalItemCount > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        elevation: 0,
        title: const Text(
          'Menu - Campus Bistro',
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Active dine-in banner
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEAF4),
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
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.tableName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: categories.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Category(
                            label: cat,
                            isSelected: selectedCategory == cat,
                            onTap: () => changeCategory(cat),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 4),
                  ...items.map((item) => Menuitemcard(
                        menuItem: item,
                        quantity: quantities[item.id] ?? 0,
                        onAdd: () => addItem(item),
                        onRemove: () => removeItem(item),
                      )),
                  if (hasCart) const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          if (hasCart)
            CartBar(
              itemCount: totalItemCount,
              totalPrice: totalPrice,
              viewOrder: goToOrderReview,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Bill',
          ),
        ],
      ),
    );
  }
}
