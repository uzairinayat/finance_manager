import 'package:flutter/material.dart';
import 'package:money_mate/styles/action_button_style.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';
import '../provider/amount_provider.dart';

class ExpenseButton extends StatelessWidget {
  const ExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context); // Responsive screens

    final List<String> expenseCategories = [
      "Food",
      "Transport",
      "Shopping",
      "Bills",
      "Health",
      "Entertainment",
      "Other",
    ];

    String? selectedCategory;
    return ActionButton(
      icon: Icons.arrow_upward,
      title: "Expense",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final expenseController = TextEditingController();

            return AlertDialog(
              backgroundColor: AppTheme.darkGray,
              elevation: 5,
              shadowColor: AppTheme.lightGray,
              title: Text(
                "Add Expense",
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
                    controller: expenseController,
                    keyboardType: TextInputType.number,
                    cursorColor: AppTheme.lightGray,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
                    decoration: InputDecoration(
                      labelText: "Expense Amount",
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
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.darkGray,
                    value: selectedCategory,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
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
                    items: expenseCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(color: AppTheme.lightGray),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedCategory = value;
                    },
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: responsive.fontSize(16, 20),
                      color: AppTheme.darkGray,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      AppTheme.lightTealGreen,
                    ),
                  ),
                  onPressed: () {
                    final amount =
                        double.tryParse(expenseController.text) ?? 0.0;
                    final category = selectedCategory.toString().trim();
                    if (amount <= 0 || category.isEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Please enter a valid income and catogory.",
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    } else {
                      context.read<AmountProvider>().addExpense(
                        amount,
                        category,
                      );
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Spent PKR $amount on $category ."),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: responsive.fontSize(16, 20),
                      color: AppTheme.lightGray,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
