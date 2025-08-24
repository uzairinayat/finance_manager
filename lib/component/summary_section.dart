import 'package:flutter/material.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:money_mate/utils/summaries.dart';

class SummarySection extends StatelessWidget {
  final double income;
  final double expense;
  final double balance;

  const SummarySection({
    super.key,
    required this.income,
    required this.expense,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Responsive screens

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkGray,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightGray,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3), // move shadow down
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Summary",
            style: TextStyle(
              color: AppTheme.lightGray,
              fontSize: responsive.fontSize(18, 24),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Summary(title: "Total Income", value: income, color: Colors.green),
          Summary(title: "Total Expense", value: expense, color: Colors.red),
          Summary(
            title: "Saving",
            value: balance,
            color: balance >= 0 ? Colors.blue : Colors.red,
          ),
        ],
      ),
    );
  }
}
