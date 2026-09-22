import 'models/MenuItem.dart';
import 'models/table.dart';
import 'models/restaurant.dart';
import 'services/Restaurant_service.dart';

void main() {
  // Setup restaurant
  final restaurant = Restaurant(name: 'My Restaurant');

  final table1 = Table(tableNumber: 1, numberOfSeats: 4);
  final table2 = Table(tableNumber: 2, numberOfSeats: 2);
  restaurant.addTable(table1);
  restaurant.addTable(table2);

  final burger = MenuItem(itemName: 'Burger', price: 8.99);
  final pizza = MenuItem(itemName: 'Pizza', price: 12.50);
  restaurant.addMenuItem(burger);
  restaurant.addMenuItem(pizza);

  final service = RestaurantService();

  // Create an order
  final order = service.createOrder(orderId: 'ORD-001', table: table1);
  if (order != null) {
    service.addItemToOrder(order: order, menuItem: burger, quantity: 2);
    service.addItemToOrder(order: order, menuItem: pizza, quantity: 1);

    print('Order: ${order.orderId}');
    print('Table: ${order.table.tableNumber}');
    for (final item in order.items) {
      print('  ${item.menuItem.itemName} x${item.quantity} = \$${item.subtotal.toStringAsFixed(2)}');
    }
    print('Total: \$${order.totalPrice.toStringAsFixed(2)}');
  }
}
