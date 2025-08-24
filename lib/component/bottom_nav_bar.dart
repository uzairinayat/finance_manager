import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/pages/budget_page.dart';
import 'package:money_mate/pages/dashboard_page.dart';
import 'package:money_mate/pages/reports_page.dart';
import 'package:money_mate/provider/navigation_provider.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});
  final List<Widget> _tabs = [
    const DashboardPage(),
    const BudgetPage(),
    const ReportsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final responsive = Responsive(context);
    return Scaffold(
      body: _tabs[navProvider.selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 30)],
          color: AppTheme.darkGray,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 5,
              activeColor: AppTheme.lightGray,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppTheme.lightTealGreen,
              color: AppTheme.lightGray,
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                  textSize: responsive.fontSize(16, 20),
                ),
                GButton(
                  icon: Icons.savings,
                  text: 'Budget',
                  textSize: responsive.fontSize(16, 20),
                ),
                GButton(
                  icon: Icons.analytics,
                  text: 'Reports',
                  textSize: responsive.fontSize(16, 20),
                ),
              ],
              selectedIndex: navProvider.selectedIndex,
              onTabChange: (index) {
                navProvider.changeIndex(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
