import 'MenuItem.dart';
import 'Table.dart';

class Restaunrant {
  String name;
  List<Table> table = [];
  List<Menuitem> menuitem = [];
  Restaunrant({
    required this.name,
    required this.table,
    required this.menuitem,
  });
}
