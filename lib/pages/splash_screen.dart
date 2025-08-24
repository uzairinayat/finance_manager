import 'package:flutter/material.dart';
import 'package:money_mate/component/bottom_nav_bar.dart';
import 'package:money_mate/pages/introduction_page.dart';
import 'package:money_mate/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_launch') ?? true;
    if (firstTime) {
      await prefs.setBool('first_launch', false);
    }
    return firstTime;
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 4)); // splash delay
    bool firstLaunch = await isFirstLaunch();

    if (!mounted) return;

    if (firstLaunch) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IntroductionPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    final logoHeight = isTablet ? 180.0 : 100.0;
    final fontSize = isTablet ? 30.0 : 24.0;
    final verticalSpacing = isTablet ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: AppTheme.darkGray,
      body: Center(
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
                size: logoHeight,
                color: AppTheme.lightGray,
              ),
            ),
            SizedBox(height: verticalSpacing),
            Text(
              "Money Mate",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGray,
              ),
            ),
            SizedBox(height: verticalSpacing),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.lightTealGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
