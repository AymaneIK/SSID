import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/patient.dart';
import '../../core/models/medical_record.dart';
import '../../core/widgets/section_header.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/medical_data_card.dart';
import 'widgets/medications_card.dart';
import 'widgets/medical_history_card.dart';
import 'widgets/lab_results_card.dart';

class MedicalProfilePage extends StatelessWidget {
  const MedicalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = Patient.mock();
    final medications = Medication.mockMedications();
    final diseases = Disease.mockDiseases();
    final allergies = Disease.mockAllergies();
    final labResults = MedicalRecord.mockRecords();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withValues(alpha: 0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Fiche patient',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 42),
                  ],
                ),
              ),
            ),

            // Personal Info Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: PersonalInfoCard(
                  name: patient.fullName,
                  role: 'Patient',
                ),
              ),
            ),

            // Patient Details Row
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _buildPatientDetailsRow(context, patient),
              ),
            ),

            // Medical Data Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    const SectionHeader(title: 'Données médicales'),
                    const SizedBox(height: 8),
                    _buildMedicalDataGrid(context),
                  ],
                ),
              ),
            ),

            // Patient Folders Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Text(
                  'Dossiers du patient',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),

            // Medications Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: MedicationsCard(medications: medications),
              ),
            ),

            // Lab Results Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: LabResultsCard(records: labResults),
              ),
            ),

            // Medical History Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: MedicalHistoryCard(
                  diseases: diseases,
                  allergies: allergies,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientDetailsRow(BuildContext context, Patient patient) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildDetailItem(context, Icons.calendar_today_rounded,
              'Date de naissance', patient.dateOfBirth),
          Container(
            width: 1,
            height: 40,
            color: AppColors.divider,
          ),
          _buildDetailItem(context, Icons.bloodtype_rounded,
              'Groupe sanguin', patient.bloodType),
          Container(
            width: 1,
            height: 40,
            color: AppColors.divider,
          ),
          _buildDetailItem(context, Icons.monitor_weight_rounded,
              'Poids', '${patient.weight} kg'),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textTertiary,
              ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }

  Widget _buildMedicalDataGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: [
        MedicalDataCard(
          title: 'Cholestérol',
          value: '<200',
          unit: 'mg/dL',
          icon: Icons.show_chart_rounded,
          color: AppColors.primary,
          chartWidget: CustomPaint(
            painter: _MiniChartPainter(
              data: [180, 195, 185, 190, 182, 178, 185],
              color: AppColors.primary,
            ),
          ),
        ),
        const MedicalDataCard(
          title: 'Radio pulmonaire',
          value: 'Normal',
          icon: Icons.medical_information_rounded,
          color: AppColors.info,
        ),
        const MedicalDataCard(
          title: 'Tension artérielle',
          value: '120/80',
          unit: 'mmHg',
          icon: Icons.speed_rounded,
          color: AppColors.success,
        ),
        const MedicalDataCard(
          title: 'Glycémie',
          value: '95',
          unit: 'mg/dL',
          icon: Icons.water_drop_rounded,
          color: AppColors.warning,
        ),
      ],
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _MiniChartPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final minVal = data.reduce((a, b) => a < b ? a : b);
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final range = maxVal - minVal;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final fillPath = Path();
    fillPath.moveTo(0, size.height);

    for (int i = 0; i < data.length; i++) {
      final x = i * size.width / (data.length - 1);
      final y = size.height - ((data[i] - minVal) / range) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw end dot
    final lastX = size.width;
    final lastY =
        size.height - ((data.last - minVal) / range) * size.height;
    canvas.drawCircle(
      Offset(lastX, lastY),
      4,
      Paint()..color = color,
    );
    canvas.drawCircle(
      Offset(lastX, lastY),
      2,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
