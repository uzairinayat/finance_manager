import 'package:flutter/material.dart';
import 'package:money_mate/component/bottom_nav_bar.dart';
import 'package:money_mate/provider/user_provider.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:money_mate/utils/responsiveness.dart';
import 'package:provider/provider.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final responsive = Responsive(context); // Responsive screens

    return Scaffold(
      backgroundColor: AppTheme.darkGray,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkGray,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lightGray,
                      spreadRadius: 3,
                      blurRadius: 12,
                      offset: const Offset(4, 4), // move shadow down
                    ),
                  ],
                ),
                child: Icon(
                  Icons.wallet,
                  size: responsive.iconSize(100, 150),
                  color: AppTheme.lightGray,
                ),
              ),
              SizedBox(height: responsive.isTablet ? 40.0 : 20.0),
              Text(
                "Welcome! Please enter your name:",
                style: TextStyle(
                  color: AppTheme.lightGray,
                  fontSize: responsive.fontSize(22, 28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  fillColor: AppTheme.lightGray,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isNotEmpty) {
                    // Save name in Provider + SharedPreferences
                    await Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).setName(nameController.text);

                    // Navigate to HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => BottomNavigation()),
                    );
                  }
                },
                child: Text(
                  "Continue to App",
                  style: TextStyle(
                    fontSize: responsive.fontSize(18, 24),
                    color: AppTheme.darkGray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
