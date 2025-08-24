import 'package:flutter/material.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:money_mate/widgets/edit_expense_button.dart';
import 'package:provider/provider.dart';

class ExpenseSection extends StatelessWidget {
  const ExpenseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
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
            'Expenses',
            style: TextStyle(
              fontSize: responsive.fontSize(18, 24),
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGray,
            ),
          ),
          const SizedBox(height: 10),
          Consumer<AmountProvider>(
            builder: (context, amountProvider, child) {
              final expenses = amountProvider.transactions
                  .where((t) => t.type == "expense")
                  .toList();

              if (expenses.isEmpty) {
                return Center(
                  child: Text(
                    "No expenses yet.",
                    style: TextStyle(
                      fontSize: responsive.fontSize(16, 20),
                      color: AppTheme.lightGray,
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Card(
                    color: AppTheme.darkGray,
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                        size: responsive.iconSize(16, 20),
                      ),
                      title: Text(
                        expense.description,
                        style: TextStyle(
                          fontSize: responsive.fontSize(16, 20),
                          color: AppTheme.lightGray,
                        ),
                      ),
                      subtitle: Text(
                        "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                        style: TextStyle(
                          fontSize: responsive.fontSize(14, 18),
                          color: AppTheme.lightGray,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            expense.amount.toStringAsFixed(2),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: responsive.fontSize(14, 18),
                            ),
                          ),
                          const SizedBox(width: 8),
                          EditExpenseButton(
                            expense: expense,
                            provider: amountProvider,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: responsive.iconSize(14, 18),
                            ),
                            onPressed: () {
                              amountProvider.deleteTransaction(expense);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
