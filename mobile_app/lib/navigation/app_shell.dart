import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/bottom_nav_bar.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/medical_profile/medical_profile_page.dart';
import '../features/medical_directory/medical_directory_page.dart';
import '../features/smart_alerts/smart_alerts_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final _pages = const [
    DashboardPage(),
    MedicalProfilePage(),
    MedicalDirectoryPage(),
    SmartAlertsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
