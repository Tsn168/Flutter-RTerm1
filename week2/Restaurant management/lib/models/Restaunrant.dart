import 'table.dart';
import 'MenuItem.dart';

class Restaurant {
  final String name;

  final List<Table> _tables = [];
  final List<MenuItem> _menuItems = [];

  Restaurant({required this.name});

  List<Table> get tables => List.unmodifiable(_tables);

  List<MenuItem> get menuItems => List.unmodifiable(_menuItems);

  void addTable(Table table) {
    _tables.add(table);
  }

  void addMenuItem(MenuItem menuItem) {
    _menuItems.add(menuItem);
  }
}
