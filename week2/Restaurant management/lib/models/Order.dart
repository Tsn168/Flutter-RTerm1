import 'Customer.dart';
import 'OrderItem.dart';
import 'Table.dart';

class Order {
  String orderId;
  Customer customer;
  Table table;
  List<Orderitem> orderItem = [];
  Order({
    required this.orderId,
    required this.customer,
    required this.orderItem,
    required this.table,
  });
}
