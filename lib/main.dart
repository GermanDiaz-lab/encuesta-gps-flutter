import 'package:flutter/material.dart';

import 'features/auth/auth_service.dart';
import 'features/home/home_screen.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return MaterialApp(
      theme: AppTheme.light(),
      home: const HomeScreen(),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        AuthScreen.routeName: (_) => AuthScreen(authService: authService),
      },
    );
  }
}
