import 'package:flutter/material.dart';
import 'package:money_mate/styles/action_button_style.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';
import '../provider/amount_provider.dart';

class IncomeButton extends StatelessWidget {
  const IncomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> incomeSources = [
      "Salary",
      "Business",
      "Freelancing",
      "Investments",
      "Other",
    ];

    String? selectedSource;

    final responsive = Responsive(context);
    return ActionButton(
      icon: Icons.arrow_downward,
      title: "Income",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final incomeController = TextEditingController();
            return AlertDialog(
              backgroundColor: AppTheme.darkGray,
              elevation: 5,
              shadowColor: AppTheme.lightGray,
              title: Text(
                "Add Income",
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
                    controller: incomeController,
                    cursorColor: AppTheme.lightGray,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Income Amount",
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
                    value: selectedSource,
                    style: TextStyle(
                      color: AppTheme.lightGray,
                      fontSize: responsive.fontSize(16, 20),
                    ),
                    decoration: InputDecoration(
                      labelText: "Source of Income",
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
                    items: incomeSources.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(
                          source,
                          style: TextStyle(color: AppTheme.lightGray),
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      selectedSource = value;
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
                        double.tryParse(incomeController.text) ?? 0.0;
                    final source = selectedSource.toString().trim();

                    if (amount <= 0 || source.isEmpty) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Please enter a valid income and source.",
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
                      context.read<AmountProvider>().addIncome(amount, source);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "PKR $amount from $source  added successfully!",
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
