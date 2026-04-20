import 'package:flutter/material.dart';
import '../../core/models/patient.dart';
import '../../core/models/health_alert.dart';
import '../../core/models/medication_reminder.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/notification_service.dart';
import 'widgets/emergency_action_banner.dart';
import 'widgets/medication_schedule_tile.dart';
import 'widgets/alert_card.dart';
import 'screens/alert_history_screen.dart';
import 'screens/add_reminder_screen.dart';

class SmartAlertsPage extends StatelessWidget {
  const SmartAlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = Patient.mock();
    final activeAlerts = HealthAlert.mockAlerts().where((a) => a.level != AlertLevel.info).toList();
    final reminders = MedicationReminder.mockReminders();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddReminderScreen()));
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
        label: const Text('Ajouter un rappel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Alertes Intelligentes', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Surveillance active pour ${patient.fullName}', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            if (activeAlerts.any((a) => a.level == AlertLevel.critical))
              SliverToBoxAdapter(
                child: EmergencyActionBanner(
                  message: activeAlerts.firstWhere((a) => a.level == AlertLevel.critical).recommendedAction ?? 'Alerte critique détectée !',
                  onActionPressed: () {
                    NotificationService.showMockNotification(
                      context,
                      title: activeAlerts.firstWhere((a) => a.level == AlertLevel.critical).title,
                      body: activeAlerts.firstWhere((a) => a.level == AlertLevel.critical).recommendedAction ?? '',
                      isCritical: true,
                    );
                  },
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Rappels du jour', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => MedicationScheduleTile(reminder: reminders[index]),
                childCount: reminders.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Alertes récentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    TextButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertHistoryScreen())),
                      child: const Text('Tout voir'),
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => AlertCard(
                  alert: activeAlerts[index],
                  onTap: () {
                    NotificationService.showMockNotification(
                      context,
                      title: activeAlerts[index].title,
                      body: activeAlerts[index].message,
                      isCritical: activeAlerts[index].level == AlertLevel.critical,
                    );
                  },
                ),
                childCount: activeAlerts.length,
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}