import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class ExpensesPieChart extends StatelessWidget {
  final Map<String, double> expenseData;

  const ExpensesPieChart({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    final total = expenseData.values.fold(0.0, (a, b) => a + b);

    final responsive = Responsive(context);

    if (total == 0) {
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "No expenses to show in chart.",
            style: TextStyle(
              color: AppTheme.lightGray,
              fontSize: responsive.fontSize(18, 24),
            ),
          ),
        ),
      );
    }

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
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expenses by Category",
            style: TextStyle(
              fontSize: responsive.fontSize(18, 24),
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGray,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: expenseData.entries.map((entry) {
                  final percentage = (entry.value / total * 100)
                      .toStringAsFixed(1);
                  return PieChartSectionData(
                    value: entry.value,
                    title: "${entry.key}\n$percentage%",
                    color: _getCategoryColor(entry.key),
                    radius: 80,
                    titleStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGray,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Food":
        return Colors.orange;
      case "Transport":
        return Colors.blue;
      case "Shopping":
        return Colors.purple;
      case "Bills":
        return Colors.red;
      case "Other":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
