import 'package:flutter/material.dart';
import 'package:money_mate/component/expense_section.dart';
import 'package:money_mate/component/saving_goal_bar.dart';
import 'package:money_mate/component/transaction_section.dart';
import 'package:money_mate/provider/user_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:money_mate/widgets/goal_button.dart';
import 'package:money_mate/widgets/income_button.dart';
import 'package:money_mate/widgets/expense_button.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final amountProvider = Provider.of<AmountProvider>(context);

    final Name = Provider.of<UserProvider>(context).name;

    final responsive = Responsive(context); // Responsive screens

    return Scaffold(
      backgroundColor: AppTheme.lightTealGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Top Balance Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.lightTealGreen,
                  borderRadius: const BorderRadius.only(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Name.isNotEmpty
                          ? "Welcome back, $Name "
                          : "Welcome to the App ",
                      style: TextStyle(
                        fontSize: responsive.fontSize(30, 36),
                        color: AppTheme.lightGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'PKR ${amountProvider.totalIncome - amountProvider.totalExpense}',
                      style: TextStyle(
                        fontSize: responsive.fontSize(28, 34),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightGray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current Balance',
                      style: TextStyle(
                        color: AppTheme.lightGray,
                        fontSize: responsive.fontSize(14, 18),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IncomeButton(),
                        ExpenseButton(),
                        GoalButton(),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.darkGray,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 20),
                    // SAVINGS SECTION
                    SavingGoalBar(),
                    SizedBox(height: 20),

                    // EXPENSES SECTION
                    ExpenseSection(),
                    SizedBox(height: 20),

                    // ALL TRANSACTIONS SECTION
                    TransactionSection(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
