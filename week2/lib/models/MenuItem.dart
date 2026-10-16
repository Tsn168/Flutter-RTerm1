class MenuItem {
  final String id;
  final String itemName;
  final double price;
  final String category; // 'Food' or 'Drinks'
  bool isAvailable;
  String image;
  String description;

  MenuItem({
    required this.id,
    required this.itemName,
    required this.price,
    required this.category,
    this.isAvailable = true,
    required this.image,
    required this.description,
  });

  void makeUnavailable() {
    isAvailable = false;
  }

  void makeAvailable() {
    isAvailable = true;
  }
}
