class Table {
  final int tableNumber;
  final int numberOfSeats;
  bool isAvailable;

  Table({
    required this.tableNumber,
    required this.numberOfSeats,
    this.isAvailable = true,
  });

  void reserve() {
    isAvailable = false;
  }

  void release() {
    isAvailable = true;
  }
}
