import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_shell.dart';

void main() {
  runApp(const SSIDApp());
}

class SSIDApp extends StatelessWidget {
  const SSIDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSID - Santé Intelligente',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}
