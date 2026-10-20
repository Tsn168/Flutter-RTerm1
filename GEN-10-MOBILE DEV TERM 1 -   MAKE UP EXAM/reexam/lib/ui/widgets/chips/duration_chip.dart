import 'package:flutter/material.dart';

///
/// A chip to display duration
///
class DurationChip extends StatelessWidget {
  final int durationInHours;
  const DurationChip({super.key, required this.durationInHours});

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    if (durationInHours < 2) {
      chipColor = Colors.green;
    } else if (durationInHours >= 5) {
      chipColor = Colors.red;
    } else {
      chipColor = Colors.orange;
    }
    return Chip(
      label: Text(
        '${durationInHours}H',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: chipColor,
    );
  }
}
