import 'Order.dart';

class Customer {
  String name;
  double phone;
  List<Order> order = [];
  Customer({required this.name, required this.phone, required this.order});
}
