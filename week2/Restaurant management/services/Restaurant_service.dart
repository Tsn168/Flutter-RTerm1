import '../lib/models/customer.dart';
import '../lib/models/OrderItem.dart';
import '../lib/models/table.dart';
import '../lib/models/MenuItem.dart';
import '../lib/models/order.dart';

class RestaurantService {
  // 1. Reserve a table
  bool reserveTable(Table table) {
    if (!table.isAvailable) {
      return false;
    }

    table.reserve();

    return true;
  }

  // 2. Create an order
  Order? createOrder({
    required String orderId,
    required Customer customer,
    required Table table,
  }) {
    if (!table.isAvailable) {
      return null;
    }

    final order = Order(orderId: orderId, customer: customer, table: table);

    customer.addOrder(order);

    table.reserve();

    return order;
  }

  // 3. Add item to an order
  bool addItemToOrder({
    required Order order,
    required MenuItem menuItem,
    required int quantity,
  }) {
    if (!menuItem.isAvailable) {
      return false;
    }

    if (quantity <= 0) {
      return false;
    }

    final orderItem = OrderItem(menuItem: menuItem, quantity: quantity);

    order.addItem(orderItem);

    return true;
  }
}
