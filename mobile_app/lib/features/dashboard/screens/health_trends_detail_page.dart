import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HealthTrendsDetailPage extends StatelessWidget {
  const HealthTrendsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Analyse des tendances', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildDetailTrendCard(
              context,
              title: 'Qualité du sommeil',
              value: '7.3h',
              change: '+0.5h vs la semaine dernière',
              isPositive: true,
              icon: Icons.nightlight_round,
              color: AppColors.primary,
              chartHeight: 180,
            ),
            const SizedBox(height: 20),
            _buildDetailTrendCard(
              context,
              title: 'Tension Artérielle',
              value: '120/80',
              change: 'Stable sur les 30 derniers jours',
              isPositive: true,
              icon: Icons.speed_rounded,
              color: AppColors.info,
              chartHeight: 180,
            ),
            const SizedBox(height: 20),
            _buildDetailTrendCard(
              context,
              title: 'Glycémie (à jeun)',
              value: '95 mg/dL',
              change: '+5 mg/dL depuis le dernier test',
              isPositive: false,
              icon: Icons.water_drop_outlined,
              color: AppColors.warning,
              chartHeight: 180,
            ),
            const SizedBox(height: 20),
            _buildDetailTrendCard(
              context,
              title: 'Poids corporel',
              value: '72.5 kg',
              change: '-0.5 kg ce mois',
              isPositive: true,
              icon: Icons.monitor_weight_rounded,
              color: AppColors.success,
              chartHeight: 180,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTrendCard(
    BuildContext context, {
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
    required double chartHeight,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    Text(change, style: TextStyle(color: isPositive ? AppColors.success : AppColors.warning, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 24),
          // Mock chart representation
          Container(
            height: chartHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomPaint(
              painter: _TrendChartPainter(color: color),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lun', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Mar', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Mer', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Jeu', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Ven', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Sam', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
              Text('Dim', style: TextStyle(color: AppColors.textTertiary, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendChartPainter extends CustomPainter {
  final Color color;
  _TrendChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final width = size.width;
    final height = size.height;

    // Random-ish looking path for the trend
    path.moveTo(0, height * 0.7);
    path.quadraticBezierTo(width * 0.2, height * 0.4, width * 0.3, height * 0.6);
    path.quadraticBezierTo(width * 0.5, height * 0.9, width * 0.7, height * 0.3);
    path.quadraticBezierTo(width * 0.9, height * 0.5, width, height * 0.2);

    canvas.drawPath(path, paint);

    // Draw gradient under path
    final fillPath = Path.from(path)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();
    
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.0)],
    );

    canvas.drawPath(fillPath, Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, width, height)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
