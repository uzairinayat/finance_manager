import 'package:flutter/material.dart';
import 'package:money_mate/provider/amount_provider.dart';
import 'package:money_mate/provider/navigation_provider.dart';
import 'package:money_mate/pages/splash_screen.dart';
import 'package:money_mate/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AmountProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadName()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
