import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/notification_service.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medNameController = TextEditingController();
  final _dosageController = TextEditingController();
  String _selectedTime = '08:00';

  @override
  void dispose() {
    _medNameController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Nouveau rappel'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _medNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du médicament',
                  prefixIcon: Icon(Icons.medication_outlined),
                ),
                validator: (value) => value!.isEmpty ? 'Requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage (ex: 500mg)',
                  prefixIcon: Icon(Icons.science_outlined),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedTime,
                decoration: const InputDecoration(
                  labelText: 'Heure de prise',
                  prefixIcon: Icon(Icons.access_time_rounded),
                ),
                items: ["06:00", "08:00", "10:00", "12:00", "14:00", "18:00", "20:00", "22:00"]
                    .map((time) => DropdownMenuItem(value: time, child: Text(time)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedTime = value!),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    NotificationService.showMockNotification(
                      context,
                      title: 'Rappel ajouté',
                      body: '${_medNameController.text} (${_dosageController.text}) programmé à $_selectedTime.',
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Enregistrer le rappel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}