class Cart {
  final String name;
  final int quantity;
  final double price;
  Cart({required this.name, required this.quantity, required this.price});

  double get totalPrice => price * quantity;
}
