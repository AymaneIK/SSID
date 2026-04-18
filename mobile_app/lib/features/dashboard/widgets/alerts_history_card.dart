import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AlertsHistoryCard extends StatelessWidget {
  const AlertsHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      _AlertItem(
        icon: Icons.medication_rounded,
        color: AppColors.info,
        title: 'Rappel médicament',
        subtitle: 'Aspirine 100mg — 08:00',
        time: 'Il y a 2h',
        severity: 'info',
      ),
      _AlertItem(
        icon: Icons.warning_amber_rounded,
        color: AppColors.warning,
        title: 'Tension élevée détectée',
        subtitle: 'Valeur: 145/95 mmHg',
        time: 'Il y a 5h',
        severity: 'warning',
      ),
      _AlertItem(
        icon: Icons.favorite_rounded,
        color: AppColors.error,
        title: 'Fréquence cardiaque',
        subtitle: 'Pic détecté: 110 bpm',
        time: 'Hier',
        severity: 'critical',
      ),
      _AlertItem(
        icon: Icons.check_circle_outline_rounded,
        color: AppColors.success,
        title: 'Analyse IA terminée',
        subtitle: 'Aucune anomalie détectée',
        time: 'Hier',
        severity: 'success',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  color: AppColors.warning,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Historique des alertes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Tout voir',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...alerts.map((alert) => _buildAlertTile(context, alert)),
        ],
      ),
    );
  }

  Widget _buildAlertTile(BuildContext context, _AlertItem alert) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: alert.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(alert.icon, color: alert.color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  alert.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            alert.time,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }
}

class _AlertItem {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;
  final String severity;

  _AlertItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.severity,
  });
}
