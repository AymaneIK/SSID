import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AlertsHistoryListPage extends StatelessWidget {
  const AlertsHistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      _AlertData(
        icon: Icons.medication_rounded,
        color: AppColors.info,
        title: 'Rappel médicament',
        subtitle: 'Aspirine 100mg — 08:00',
        date: '18 Avril 2024',
        time: '08:00',
        severity: 'Information',
      ),
      _AlertData(
        icon: Icons.warning_amber_rounded,
        color: AppColors.warning,
        title: 'Tension élevée détectée',
        subtitle: 'Valeur: 145/95 mmHg',
        date: '18 Avril 2024',
        time: '12:30',
        severity: 'Attention',
      ),
      _AlertData(
        icon: Icons.favorite_rounded,
        color: AppColors.error,
        title: 'Fréquence cardiaque',
        subtitle: 'Pic détecté: 110 bpm',
        date: '17 Avril 2024',
        time: '22:15',
        severity: 'Critique',
      ),
      _AlertData(
        icon: Icons.check_circle_outline_rounded,
        color: AppColors.success,
        title: 'Analyse IA terminée',
        subtitle: 'Aucune anomalie détectée',
        date: '17 Avril 2024',
        time: '18:00',
        severity: 'Succès',
      ),
      _AlertData(
        icon: Icons.water_drop_outlined,
        color: AppColors.warning,
        title: 'Glycémie instable',
        subtitle: 'Valeur: 115 mg/dL',
        date: '16 Avril 2024',
        time: '07:30',
        severity: 'Attention',
      ),
      _AlertData(
        icon: Icons.directions_walk_rounded,
        color: AppColors.primary,
        title: 'Objectif activité',
        subtitle: '10,000 pas atteints',
        date: '15 Avril 2024',
        time: '20:00',
        severity: 'Félicitations',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Toutes les alertes', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fichier SSID_Alerts.csv téléchargé avec succès'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: alert.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(alert.icon, color: alert.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(alert.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)), // Changed to font 13
                          Text(alert.date, style: const TextStyle(color: AppColors.textTertiary, fontSize: 14)), // Changed to font 11
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(alert.subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: alert.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              alert.severity,
                              style: TextStyle(color: alert.color, fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                          ),
                          const Spacer(),
                          Text(alert.time, style: const TextStyle(color: AppColors.textTertiary, fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AlertData {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String severity;

  _AlertData({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.severity,
  });
}
