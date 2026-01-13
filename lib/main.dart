import 'package:flutter/material.dart';

import 'features/auth/auth_service.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return MaterialApp(
      home: AuthScreen(authService: authService),
    );
  }
}
