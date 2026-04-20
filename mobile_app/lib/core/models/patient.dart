import 'medical_record.dart';

class Patient {
  final String id;
  final String cin;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String bloodType;
  final double weight;
  final double height;
  final String? avatarUrl;
  final List<Disease> conditions;
  final List<Medication> medications;

  const Patient({
    required this.id,
    required this.cin,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.bloodType,
    required this.weight,
    required this.height,
    this.avatarUrl,
    this.conditions = const [],
    this.medications = const [],
  });

  String get fullName => '$firstName $lastName';

  static Patient mock() => const Patient(
    id: '1',
    cin: 'AB123456',
    firstName: 'Aymane',
    lastName: 'Ikendiden',
    dateOfBirth: '14/10/2004',
    bloodType: 'A+',
    weight: 61.2,
    height: 178,
    avatarUrl: null,
    conditions: [
      Disease(name: 'Asthme', type: 'chronic', diagnosedDate: '2018', notes: 'Léger, contrôlé par traitement'),
      Disease(name: 'Allergie au pollen', type: 'allergy', diagnosedDate: '2015'),
      Disease(name: 'Fracture du bras', type: 'past', diagnosedDate: '2020',  notes: 'Complètement guéri'),
    ],
    medications: [
      Medication(name: 'Metformine', dosage: '500mg', frequency: '2 fois/jour'),
      Medication(name: 'Ramipril', dosage: '5mg', frequency: '1 fois/jour'),
    ],
  );
}