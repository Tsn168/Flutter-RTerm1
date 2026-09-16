import 'customer.dart';
import 'table.dart';
import 'OrderItem.dart';

class Order {
  final String orderId;
  final Customer customer;
  final Table table;

  final List<OrderItem> items = [];

  Order({required this.orderId, required this.customer, required this.table});

  double get totalPrice {
    double total = 0;

    for (final item in items) {
      total = total + item.subtotal;
    }

    return total;
  }

  void addItem(OrderItem item) {
    items.add(item);
  }

  void removeItem(OrderItem item) {
    items.remove(item);
  }
}
