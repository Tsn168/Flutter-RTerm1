import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = "All";

  final List<MenuItem> menuitems = [];

  final Map<String, int> quantities = {};

  void ChangeCatrgory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void addItem(MenuItem item) {
    setState(() {});
  }

  void removedItem(MenuItem item) {
    setState(() {});
  }

  List<MenuItem> get filterItem {
    if (selectedCategory == 'All') {
      return menuitems;
    } else {
      return menuitems.where((items) {
        return item.category == selectedCategory;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
