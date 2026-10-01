class MenuItem {
  final String itemName;
  final double price;
  bool isAvailable;
  String image;
  String description;

  MenuItem(
      {required this.itemName,
      required this.price,
      this.isAvailable = true,
      required this.image,
      required this.description});

  void makeUnavailable() {
    isAvailable = false;
  }

  void makeAvailable() {
    isAvailable = true;
  }
}
