import 'package:flutter/material.dart';
import 'package:money_mate/model/transaction_model.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class EditExpenseButton extends StatelessWidget {
  final TransactionModel expense;
  final AmountProvider provider;

  const EditExpenseButton({
    super.key,
    required this.expense,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController(
      text: expense.amount.toString(),
    );
    String selectedCategory = expense.description;

    final responsive = Responsive(context); // Responsive screens

    return IconButton(
      icon: Icon(
        Icons.edit,
        color: AppTheme.turquoise,
        size: responsive.iconSize(14, 18),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppTheme.darkGray,
              elevation: 5,
              shadowColor: AppTheme.lightGray,
              title: Text(
                "Edit Expense",
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 22),
                  color: AppTheme.lightGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.lightGray,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
                    decoration: InputDecoration(
                      labelText: "Amount",
                      labelStyle: TextStyle(
                        color: AppTheme.lightGray,
                        fontSize: responsive.fontSize(16, 20),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.darkGray,
                    value: selectedCategory,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
                    items:
                        [
                              "Food",
                              "Transport",
                              "Shopping",
                              "Bills",
                              "Health",
                              "Entertainment",
                              "Other",
                            ]
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      selectedCategory = value!;
                    },
                    decoration: InputDecoration(
                      labelText: "Category",
                      labelStyle: TextStyle(
                        color: AppTheme.lightGray,
                        fontSize: responsive.fontSize(16, 20),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.lightGray,
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: responsive.fontSize(16, 20),
                      color: AppTheme.darkGray,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.lightTealGreen,
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: responsive.fontSize(16, 20),
                      color: AppTheme.lightGray,
                    ),
                  ),
                  onPressed: () {
                    final updatedAmount =
                        double.tryParse(amountController.text) ?? 0.0;

                    provider.updateTransaction(
                      expense,
                      updatedAmount,
                      selectedCategory,
                    );

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Expense updated successfully!"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
