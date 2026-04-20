class MedicationReminder {
  final String id;
  final String medicationName;
  final String dosage;
  final String frequency;
  final List<String> scheduledTimes;
  final bool isActive;

  const MedicationReminder({
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.scheduledTimes,
    this.isActive = true,
  });

  static List<MedicationReminder> mockReminders() => const [
    MedicationReminder(
      id: 'r1',
      medicationName: 'Aspirine',
      dosage: '100mg',
      frequency: '1x/jour',
      scheduledTimes: ["08:00"],
    ),
    MedicationReminder(
      id: 'r2',
      medicationName: 'Diclofenac',
      dosage: '50mg',
      frequency: '2x/jour',
      scheduledTimes: ["08:00", "20:00"],
    ),
    MedicationReminder(
      id: 'r3',
      medicationName: 'Oméprazole',
      dosage: '20mg',
      frequency: '1x/jour',
      scheduledTimes: ["07:00"],
    ),
  ];
}