import 'package:test/test.dart';

import '../../lib/services/Restaurant_service.dart';
import '../../lib/models/table.dart';
import '../../lib/models/MenuItem.dart';

void main() {
  test('Available table can be reserved', () {
    final service = RestaurantService();
    final table = Table(tableNumber: 1, numberOfSeats: 4);

    final result = service.reserveTable(table);

    expect(result, true);
    expect(table.isAvailable, false);
  });

  test('Unavailable table cannot be reserved', () {
    final service = RestaurantService();
    final table = Table(tableNumber: 1, numberOfSeats: 4, isAvailable: false);

    final result = service.reserveTable(table);

    expect(result, false);
  });

  test('Can create order with available table', () {
    final service = RestaurantService();

    final table = Table(tableNumber: 1, numberOfSeats: 4);

    final order = service.createOrder(orderId: 'O001', table: table);

    expect(order, isNotNull);
    expect(table.isAvailable, false);
  });

  test('Can add available menu item to order', () {
    final service = RestaurantService();

    final table = Table(tableNumber: 1, numberOfSeats: 4);

    final order = service.createOrder(orderId: 'O001', table: table);

    final menuItem = MenuItem(itemName: 'Fried Rice', price: 5.0);

    final result = service.addItemToOrder(
      order: order!,
      menuItem: menuItem,
      quantity: 2,
    );

    expect(result, true);
    expect(order.items.length, 1);
  });

  test('Cannot add item with quantity 0', () {
    final service = RestaurantService();

    final table = Table(tableNumber: 1, numberOfSeats: 4);

    final order = service.createOrder(orderId: 'O001', table: table);

    final menuItem = MenuItem(itemName: 'Fried Rice', price: 5.0);

    final result = service.addItemToOrder(
      order: order!,
      menuItem: menuItem,
      quantity: 0,
    );

    expect(result, false);
  });
}
