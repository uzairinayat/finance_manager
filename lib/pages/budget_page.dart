import 'package:flutter/material.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:money_mate/widgets/set_budget_button.dart';
import 'package:provider/provider.dart';
import '../provider/amount_provider.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AmountProvider>(context);
    final responsive = Responsive(context); // Responsive screens

    final categories = ["Food", "Transport", "Shopping", "Bills", "Other"];

    final categoryIcons = {
      "Food": Icons.fastfood,
      "Transport": Icons.directions_bus,
      "Shopping": Icons.shopping_bag,
      "Bills": Icons.receipt_long,
      "Other": Icons.category,
    };
    return Scaffold(
      backgroundColor: AppTheme.darkGray,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTealGreen,
        title: Text(
          "Budgeting",
          style: TextStyle(
            color: AppTheme.lightGray,
            fontWeight: FontWeight.bold,
            fontSize: responsive.fontSize(20, 26),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final budget = provider.budgets[category]?.amount ?? 0;
          final spent = provider.getSpentForCategory(category);
          final progress = provider.getBudgetProgress(category);

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: ListTile(
              leading: Icon(
                categoryIcons[category],
                color: AppTheme.turquoise,
                size: responsive.iconSize(24, 30),
              ),
              title: Text(
                category,
                style: TextStyle(
                  fontSize: responsive.fontSize(16, 20),
                  color: AppTheme.lightGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Budget: PKR ${budget.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: responsive.fontSize(14, 18),
                      color: AppTheme.lightGray,
                    ),
                  ),
                  Text(
                    "Spent: PKR ${spent.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: responsive.fontSize(14, 18),
                      color: AppTheme.lightGray,
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                      progress < 1 ? Colors.blue : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (budget > 0 && spent >= budget)
                    Text(
                      "Budget Exceeded",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: responsive.fontSize(12, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
              trailing: SetBudgetButton(
                provider: provider,
                category: category,
                currentBudget: budget,
              ),
            ),
          );
        },
      ),
    );
  }
}
