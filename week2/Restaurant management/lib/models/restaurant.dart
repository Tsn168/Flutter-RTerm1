import 'table.dart';
import 'MenuItem.dart';

class Restaurant {
  final String name;

  final List<Table> tables = [];
  final List<MenuItem> menuItems = [];

  Restaurant({required this.name});

  void addTable(Table table) {
    tables.add(table);
  }

  void addMenuItem(MenuItem menuItem) {
    menuItems.add(menuItem);
  }
}
