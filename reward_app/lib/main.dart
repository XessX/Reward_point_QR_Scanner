import 'package:flutter/material.dart';
import 'package:reward_app/main_page.dart';
import 'package:reward_app/styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(color: AppColors.primaryColor)),
      home: const MainPage(),
    );
  }
}
