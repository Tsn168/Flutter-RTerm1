import 'customer.dart';
import 'table.dart';
import 'OrderItem.dart';

class Order {
  final String orderId;
  final Customer customer;
  final Table table;

  final List<OrderItem> _items = [];

  Order({required this.orderId, required this.customer, required this.table});

  List<OrderItem> get items => List.unmodifiable(_items);

  double get totalPrice {
    double total = 0;

    for (final item in _items) {
      total += item.subtotal;
    }

    return total;
  }

  void addItem(OrderItem item) {
    _items.add(item);
  }

  void removeItem(OrderItem item) {
    _items.remove(item);
  }
}
