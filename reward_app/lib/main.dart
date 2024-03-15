import 'package:flutter/material.dart';
import 'package:reward_app/screens/main_page.dart';
import 'package:reward_app/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reward_app/user_auth/auth_checker.dart';
import 'firebase_options.dart';
import 'screens/login_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(color: AppColors.primaryColor)),
      home: const AuthChecker(),
    );
  }
}
