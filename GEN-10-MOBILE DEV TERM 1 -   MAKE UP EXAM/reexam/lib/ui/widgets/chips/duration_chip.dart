import 'package:flutter/material.dart';

///
/// A chip to display duration
///
class DurationChip extends StatelessWidget {
  final int duration;
  const DurationChip({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    if (duration < 2) {
      chipColor = Colors.green;
    } else if (duration >= 5) {
      chipColor = Colors.red;
    } else {
      chipColor = Colors.orange;
    }
    return Chip(
      label: Text(
        '${duration}',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: chipColor,
    );
  }
}
