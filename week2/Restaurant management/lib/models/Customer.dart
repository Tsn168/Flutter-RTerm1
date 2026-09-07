import 'order.dart';

class Customer {
  final String name;
  final String phone;

  final List<Order> _orders = [];

  Customer({required this.name, required this.phone});

  List<Order> get orders => List.unmodifiable(_orders);

  void addOrder(Order order) {
    _orders.add(order);
  }
}
