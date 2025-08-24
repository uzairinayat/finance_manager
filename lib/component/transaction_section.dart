import 'package:flutter/material.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:money_mate/utils/transaction_tile.dart';
import 'package:provider/provider.dart';

class TransactionSection extends StatelessWidget {
  const TransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final amountProvider = Provider.of<AmountProvider>(context);

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
            "All Transactions",
            style: TextStyle(
              fontSize: responsive.fontSize(18, 24),
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGray
            ),
          ),
          const SizedBox(height: 10),
          amountProvider.transactions.isEmpty
              ? Center(
                  child: Text(
                    "No transactions yet.",
                    style: TextStyle(fontSize: responsive.fontSize(14, 18),
                    color: AppTheme.lightGray),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: amountProvider.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = amountProvider.transactions[index];
                    return TransactionTile(transaction: transaction);
                  },
                ),
        ],
      ),
    );
  }

  // Widget _transactionTile(TransactionModel transaction) {
  //   final isIncome = transaction.type == "income";
    
  //   return Card(
  //     color: AppTheme.darkGray,
  //     elevation: 5,
  //     margin: const EdgeInsets.symmetric(vertical: 6),
  //     child: ListTile(
  //       leading: Icon(
  //         isIncome ? Icons.arrow_downward : Icons.arrow_upward,
  //         color: isIncome ? Colors.green : Colors.red,
  //       ),
  //       title: Text(transaction.description),
  //       subtitle: Text(
  //         "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
  //       style: TextStyle( color: AppTheme.lightGray),),
  //       trailing: Text(
  //         "Rs. ${transaction.amount.toStringAsFixed(2)}",
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: isIncome ? Colors.green : Colors.red,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
