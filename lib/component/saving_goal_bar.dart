import 'package:flutter/material.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';

class SavingGoalBar extends StatelessWidget {
  const SavingGoalBar({super.key});

  @override
  Widget build(BuildContext context) {
    final amountProvider = Provider.of<AmountProvider>(context);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Savings",
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 28),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGray,
                ),
              ),
              Text(
                "PKR ${amountProvider.currentSavings.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: responsive.fontSize(16, 20),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.turquoise,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: amountProvider.savingsProgress,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(AppTheme.turquoise),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(
                "Goal: PKR ${amountProvider.savingsGoal.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: responsive.fontSize(18, 28),
                  color: AppTheme.lightGray,
                ),
              ),
              Spacer(),
              if (amountProvider.goalAchieved)
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppTheme.lightgreen,
                      size: responsive.iconSize(18, 28),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Goal Achieved!",
                      style: TextStyle(
                        color: AppTheme.lightgreen,
                        fontSize: responsive.fontSize(14, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
