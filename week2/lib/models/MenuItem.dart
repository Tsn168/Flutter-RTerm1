class MenuItem {
  final String itemName;
  final double price;
  bool isAvailable;

  MenuItem({
    required this.itemName,
    required this.price,
    this.isAvailable = true,
  });

  void makeUnavailable() {
    isAvailable = false;
  }

  void makeAvailable() {
    isAvailable = true;
  }
}
