import 'package:flutter/material.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Responsive screens

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightGray,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightGray,
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(1, 3), // move shadow down
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24),
            ),
            child: Icon(
              icon,
              color: AppTheme.darkGray,
              size: responsive.iconSize(20, 24),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: responsive.fontSize(16, 20),
            color: AppTheme.lightGray,
          ),
        ),
      ],
    );
  }
}
