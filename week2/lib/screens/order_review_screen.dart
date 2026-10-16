import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';
import 'package:restaurant_management/widget/OrderItemCard.dart';
import 'order_confirmation_screen.dart';

class OrderReviewScreen extends StatefulWidget {
  final String tableName;
  final List<MenuItem> cartItems;
  final Map<String, int> quantities;

  const OrderReviewScreen({
    super.key,
    required this.tableName,
    required this.cartItems,
    required this.quantities,
  });

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  late List<MenuItem> cartItems;
  late Map<String, int> quantities;

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
    quantities = Map.from(widget.quantities);
  }

  void addItem(MenuItem item) {
    setState(() {
      quantities[item.id] = (quantities[item.id] ?? 0) + 1;
    });
  }

  void removeItem(MenuItem item) {
    setState(() {
      final current = quantities[item.id] ?? 0;
      if (current > 1) {
        quantities[item.id] = current - 1;
      } else {
        quantities.remove(item.id);
        cartItems.remove(item);
      }
    });
  }

  double get subtotal {
    double total = 0;
    for (final item in cartItems) {
      total += item.price * (quantities[item.id] ?? 0);
    }
    return total;
  }

  void placeOrder() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderConfirmationScreen(
          tableName: widget.tableName,
          cartItems: cartItems,
          quantities: quantities,
          orderId: '001',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        elevation: 0,
        title: Text(
          'Current Order - ${widget.tableName}',
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Review header card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEAF4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5D5C0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.table_restaurant,
                        color: brown, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Review',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.tableName,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Selected Dishes
            Text(
              'Selected Dishes (${cartItems.length})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Order item cards
            ...cartItems.map((item) => OrderItemCard(
                  menuItem: item,
                  quantity: quantities[item.id] ?? 0,
                  onAdd: () => addItem(item),
                  onRemove: () => removeItem(item),
                )),

            const SizedBox(height: 12),

            // Add more items button
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.pop(context, quantities),
                icon: const Icon(Icons.arrow_back, size: 16, color: brown),
                label: const Text(
                  'Add more items from Menu',
                  style: TextStyle(color: brown),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEAEAF4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Calculation
            const Text(
              'Order Calculation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal',
                    style: TextStyle(fontSize: 15, color: Colors.black54)),
                Text(
                  '\$${subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Final balance for ${widget.tableName}',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black45),
                    ),
                  ],
                ),
                Text(
                  '\$${subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: brown,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Place Order button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartItems.isEmpty ? null : placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'PLACE ORDER',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Bill',
          ),
        ],
      ),
    );
  }
}
