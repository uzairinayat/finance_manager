import 'package:flutter/material.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class Summary extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  const Summary({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Responsive screens

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.lightGray,
              fontSize: responsive.fontSize(16, 20),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "PKR ${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: responsive.fontSize(16, 20),
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
