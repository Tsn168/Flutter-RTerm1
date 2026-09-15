import 'order.dart';

class Customer {
  final String name;
  final String phone;

  final List<Order> orders = [];

  Customer({required this.name, required this.phone});

  void addOrder(Order order) {
    orders.add(order);
  }
}
