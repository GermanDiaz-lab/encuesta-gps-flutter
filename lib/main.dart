import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/auth/auth_service.dart';
import 'features/home/home_screen.dart';
import 'features/survey/survey_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return MaterialApp(
      theme: AppTheme.light(),
      home: const SurveyPage(),
      routes: {
        AuthScreen.routeName: (_) => AuthScreen(authService: authService),
        SurveyPage.routeName: (_) => const SurveyPage(),
      },
    );
  }
}
