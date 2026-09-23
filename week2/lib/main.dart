import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B3A1A)),
        useMaterial3: true,
      ),
      home: const AppRoot(),
    );
  }
}

// Root widget that holds state and passes it down as props (stateful only here)
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _showMenu = false;
  String _selectedCategory = 'All';

  final List<MenuItemData> _items = [
    const MenuItemData(
      name: 'Fried Rice',
      description: 'Fried rice with chicken, egg and scallions',
      price: 3.50,
      isAvailable: true,
      category: 'Food',
      quantity: 1,
    ),
    const MenuItemData(
      name: 'Beef Noodle',
      description: 'Slow-braised beef broth with tender noodles',
      price: 4.00,
      isAvailable: true,
      category: 'Food',
      quantity: 1,
    ),
    const MenuItemData(
      name: 'Spring Rolls',
      description: 'Crispy vegetable rolls with sweet chili dip',
      price: 2.50,
      isAvailable: true,
      category: 'Food',
      quantity: 0,
    ),
    const MenuItemData(
      name: 'Coke',
      description: 'Chilled 330ml can with ice cup',
      price: 1.00,
      isAvailable: false,
      category: 'Drinks',
      quantity: 0,
    ),
  ];

  void _addItem(MenuItemData item) {
    setState(() {
      final index = _items.indexOf(item);
      _items[index] = MenuItemData(
        name: item.name,
        description: item.description,
        price: item.price,
        isAvailable: item.isAvailable,
        category: item.category,
        imageUrl: item.imageUrl,
        quantity: item.quantity + 1,
      );
    });
  }

  void _removeItem(MenuItemData item) {
    if (item.quantity == 0) return;
    setState(() {
      final index = _items.indexOf(item);
      _items[index] = MenuItemData(
        name: item.name,
        description: item.description,
        price: item.price,
        isAvailable: item.isAvailable,
        category: item.category,
        imageUrl: item.imageUrl,
        quantity: item.quantity - 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMenu) {
      return WelcomeScreen(
        tableName: 'Table 05',
        onViewMenu: () => setState(() => _showMenu = true),
      );
    }

    return MenuScreen(
      restaurantName: 'Campus Bistro',
      tableName: 'Table 05',
      selectedCategory: _selectedCategory,
      items: _items,
      onCategorySelected: (c) => setState(() => _selectedCategory = c),
      onAdd: _addItem,
      onRemove: _removeItem,
      onViewOrder: () {},
    );
  }
}
