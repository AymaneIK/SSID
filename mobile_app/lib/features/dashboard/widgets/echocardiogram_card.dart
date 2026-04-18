import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ECGCard extends StatefulWidget {
  const ECGCard({super.key});

  @override
  State<ECGCard> createState() => _ECGCardState();
}

class _ECGCardState extends State<ECGCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMetricExplanation(BuildContext context, String title, String definition) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.info_outline_rounded, color: AppColors.error),
                ),
                const SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              definition,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.monitor_heart_rounded,
                  color: AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ECG',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    'Temps réel',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              _buildPulseIndicator(),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ECGPainter(progress: _controller.value),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildMetricsGrid(context),
        ],
      ),
    );
  }

  Widget _buildPulseIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'En direct',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _showMetricExplanation(context, 'PR', 'Intervalle représentant le temps mis par l’influx électrique pour passer des oreillettes aux ventricules.'),
          child: _metricItem('PR', '164', 'ms'),
        ),
        GestureDetector(
          onTap: () => _showMetricExplanation(context, 'QRS', 'Le complexe QRS correspond à la dépolarisation des ventricules du cœur, entraînant leur contraction.'),
          child: _metricItem('QRS', '92', 'ms'),
        ),
        GestureDetector(
          onTap: () => _showMetricExplanation(context, 'QT/QTc', 'Durée totale de la dépolarisation et repolarisation ventriculaire. Le QTc est la valeur corrigée par la fréquence cardiaque.'),
          child: _metricItem('QT/QTc', '392/414', 'ms'),
        ),
        GestureDetector(
          onTap: () => _showMetricExplanation(context, 'P/QRS/T', 'Indique l’axe électrique moyen du cœur pour chaque onde. Un changement peut indiquer une hypertrophie ou un bloc.'),
          child: _metricItem('P/QRS/T', '58/64/45', '°'),
        ),
      ],
    );
  }

  Widget _metricItem(String label, String value, String unit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ECGPainter extends CustomPainter {
  final double progress;

  _ECGPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final gridPaint = Paint()
      ..color = AppColors.error.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

    // Draw grid
    for (double i = 0; i <= size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i <= size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerY = height / 2;

    for (double x = 0; x <= width; x++) {
      // Create a repeating ECG pattern
      double normalizedX = (x / width + progress) % 1.0;
      double y = _getECGY(normalizedX, height);
      
      if (x == 0) {
        path.moveTo(x, centerY + y);
      } else {
        path.lineTo(x, centerY + y);
      }
    }

    // Glow effect
    canvas.drawPath(
        path,
        Paint()
          ..color = AppColors.error.withValues(alpha: 0.3)
          ..strokeWidth = 6
          ..style = PaintingStyle.stroke
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));

    canvas.drawPath(path, paint);
  }

  double _getECGY(double x, double height) {
    // x is 0.0 to 1.0
    // Simplified ECG pattern: P, QRS complex, T
    double y = 0;
    
    // P wave (small bump)
    if (x > 0.1 && x < 0.2) {
      y = -8 * sin(pi * (x - 0.1) / 0.1);
    } 
    // QRS complex (sharp spike)
    else if (x > 0.25 && x < 0.35) {
      double t = (x - 0.25) / 0.1;
      if (t < 0.2) {
        y = 10 * (t / 0.2); // Q
      } else if (t < 0.5) {
        y = 10 - 50 * ((t - 0.2) / 0.3); // R
      } else if (t < 0.8) {
        y = -40 + 50 * ((t - 0.5) / 0.3); // S
      } else {
        y = 10 * (1 - (t - 0.8) / 0.2); // Back to baseline
      }
    }
    // T wave (medium bump)
    else if (x > 0.45 && x < 0.65) {
      y = -15 * sin(pi * (x - 0.45) / 0.2);
    }
    
    return y;
  }

  @override
  bool shouldRepaint(covariant _ECGPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
