import 'package:flutter/material.dart';
import 'package:money_mate/component/expenses_pie_chart.dart';
import 'package:money_mate/component/summary_section.dart';
import 'package:money_mate/component/transaction_section.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AmountProvider>(context);

    final responsive = Responsive(context); // Responsive screens

    final totalIncome = provider.totalIncome;
    final totalExpense = provider.totalExpense;
    final balance = totalIncome - totalExpense;

    // Categories for pie chart
    final categories = ["Food", "Transport", "Shopping", "Bills", "Other"];
    final expenseData = <String, double>{};

    for (var cat in categories) {
      expenseData[cat] = provider.getSpentForCategory(cat);
    }

    return Scaffold(
      backgroundColor: AppTheme.darkGray,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTealGreen,
        title: Text(
          "Reports & Analytics",
          style: TextStyle(
            color: AppTheme.lightGray,
            fontWeight: FontWeight.bold,
            fontSize: responsive.fontSize(20, 26),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Summary Section
            SummarySection(
              income: totalIncome,
              expense: totalExpense,
              balance: balance,
            ),

            const SizedBox(height: 20),

            /// Expenses Pie Chart
            ExpensesPieChart(expenseData: expenseData),

            // _buildExpensesPieChart(expenseData),
            const SizedBox(height: 20),

            // Transactions List
            TransactionSection(),
          ],
        ),
      ),
    );
  }
}
