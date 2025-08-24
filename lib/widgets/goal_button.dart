import 'package:flutter/material.dart';
import 'package:money_mate/styles/action_button_style.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';
import '../provider/amount_provider.dart';

class GoalButton extends StatelessWidget {
  const GoalButton({super.key});

  @override
  Widget build(BuildContext context) {
    final goalController = TextEditingController();
    final responsive = Responsive(context);
    return ActionButton(
      icon: Icons.archive,
      title: "Set Goal",
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppTheme.darkGray,
              elevation: 5,
              shadowColor: AppTheme.lightGray,
              title: Text(
                "Set Savings Goal",
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 22),
                  color: AppTheme.lightGray,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                cursorColor: AppTheme.lightGray,
                style: TextStyle(
                  color: AppTheme.lightGray,
                  fontSize: responsive.fontSize(16, 20),
                ),
                decoration: InputDecoration(
                  labelText: "Enter goal amount",
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
                    final goal = double.tryParse(goalController.text) ?? 0;
                    if (goal > 0) {
                      context.read<AmountProvider>().setSavingsGoal(goal);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Goal set: PKR $goal"),
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
                          content: const Text("Please set a valid goal "),
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
