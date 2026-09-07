import 'menu_item.dart';

class OrderItem {
  final MenuItem menuItem;
  final int quantity;

  OrderItem({required this.menuItem, required this.quantity});

  double get subtotal => menuItem.price * quantity;
}
