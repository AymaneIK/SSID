import 'package:flutter/material.dart';
import '../../../../core/models/health_alert.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/alert_card.dart';

class AlertHistoryScreen extends StatelessWidget {
  const AlertHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allAlerts = HealthAlert.mockAlerts();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Historique des alertes'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        itemCount: allAlerts.length,
        itemBuilder: (context, index) => AlertCard(alert: allAlerts[index]),
      ),
    );
  }
}