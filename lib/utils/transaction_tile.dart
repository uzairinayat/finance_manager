import 'package:flutter/material.dart';
import 'package:money_mate/model/transaction_model.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == "income";
    final responsive = Responsive(context);

    return Card(
      color: AppTheme.darkGray,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        leading: Icon(
          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: isIncome ? Colors.green : Colors.red,
        ),
        title: Text(
          transaction.description,
          style: TextStyle(
            color:AppTheme.lightGray,
            fontWeight: FontWeight.bold,
            fontSize: responsive.fontSize(16, 20)
          ),
        ),
        subtitle: Text(
          "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
          style: TextStyle(color: AppTheme.lightGray,fontSize: responsive.fontSize(14, 18)),
        ),
        trailing: Text(
          "Rs. ${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: responsive.fontSize(14, 18),
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
