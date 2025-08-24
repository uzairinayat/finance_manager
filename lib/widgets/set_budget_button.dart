import 'package:flutter/material.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';

class SetBudgetButton extends StatelessWidget {
  final AmountProvider provider;
  final String category;
  final double currentBudget;

  const SetBudgetButton({
    super.key,
    required this.provider,
    required this.category,
    required this.currentBudget,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    final responsive = Responsive(context); // Responsive screens

    return IconButton(
      icon: Icon(
        Icons.edit,
        size: responsive.iconSize(18, 24),
        color: AppTheme.lightGray,
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
                "Set Budget for $category",
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 22),
                  color: AppTheme.lightGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                cursorColor: AppTheme.lightGray,
                style: TextStyle(
                  color: AppTheme.lightGray,
                  fontSize: responsive.fontSize(16, 20),
                ),
                decoration: InputDecoration(
                  labelText: "Enter budget amount",
                  labelStyle: TextStyle(
                    color: AppTheme.lightGray,
                    fontSize: responsive.fontSize(16, 20),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                    final amount = double.tryParse(controller.text) ?? 0.0;
                    if (amount > 0) {
                      provider.setBudget(category, amount);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "You’ve set a budget of PKR $amount for $category .",
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Please set valid budget"),
                          backgroundColor: Colors.red,
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}
