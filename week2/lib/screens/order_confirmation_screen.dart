import 'package:flutter/material.dart';
import 'package:restaurant_management/models/MenuItem.dart';
import 'menu_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String tableName;
  final String orderId;
  final List<MenuItem> cartItems;
  final Map<String, int> quantities;

  const OrderConfirmationScreen({
    super.key,
    required this.tableName,
    required this.orderId,
    required this.cartItems,
    required this.quantities,
  });

  double get total {
    double t = 0;
    for (final item in cartItems) {
      t += item.price * (quantities[item.id] ?? 0);
    }
    return t;
  }

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Green checkmark circle
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: brown,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 24),

                    // ORDER RECEIVED
                    const Text(
                      'ORDER RECEIVED',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your order was sent to the restaurant kitchen.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 32),

                    // Order card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Order ID
                          Row(
                            children: [
                              const Icon(Icons.receipt_long,
                                  color: brown, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Order #$orderId',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),

                          // Dining Location
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.chair_outlined,
                                      size: 16, color: Colors.black45),
                                  SizedBox(width: 6),
                                  Text(
                                    'Dining Location',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEAEAF4),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  tableName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Items Ordered
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5FA),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ITEMS ORDERED',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black45,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...cartItems.map((item) {
                                  final qty =
                                      quantities[item.id] ?? 0;
                                  final lineTotal = item.price * qty;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        Text(
                                          '${qty}× ${item.itemName}',
                                          style: const TextStyle(
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '\$${lineTotal.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Total Billed
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Billed',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$${total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: brown,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back to Menu button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Pop back to root and restart menu
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MenuScreen(tableName: tableName),
                      ),
                      (route) => false,
                    );
                  },
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
                    'BACK TO MENU',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
