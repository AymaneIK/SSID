import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/health_alert.dart';

class AlertCard extends StatelessWidget {
  final HealthAlert alert;
  final VoidCallback? onTap;

  const AlertCard({super.key, required this.alert, this.onTap});

  Color _getBackgroundColor() {
    switch (alert.level) {
      case AlertLevel.critical: return AppColors.error.withValues(alpha: 0.1);
      case AlertLevel.warning: return AppColors.warning.withValues(alpha: 0.1);
      case AlertLevel.info: return AppColors.primary.withValues(alpha: 0.1);
    }
  }

  Color _getIconColor() {
    switch (alert.level) {
      case AlertLevel.critical: return AppColors.error;
      case AlertLevel.warning: return AppColors.warning;
      case AlertLevel.info: return AppColors.primary;
    }
  }

  IconData _getIcon() {
    switch (alert.level) {
      case AlertLevel.critical: return Icons.error_rounded;
      case AlertLevel.warning: return Icons.warning_amber_rounded;
      case AlertLevel.info: return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _getIconColor().withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_getIcon(), color: _getIconColor(), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(alert.message, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                  const SizedBox(height: 8),
                  Text(
                    '${alert.timestamp.hour}:${alert.timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),
            if (alert.level == AlertLevel.critical)
              const Icon(Icons.chevron_right, color: AppColors.error),
          ],
        ),
      ),
    );
  }
}