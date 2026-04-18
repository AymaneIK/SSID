class MedicalRecord {
  final String id;
  final String type;
  final String title;
  final String value;
  final String date;
  final String? unit;
  final String? status; // normal, warning, critical

  const MedicalRecord({
    required this.id,
    required this.type,
    required this.title,
    required this.value,
    required this.date,
    this.unit,
    this.status,
  });

  static List<MedicalRecord> mockRecords() => const [
        MedicalRecord(
          id: '1',
          type: 'cholesterol',
          title: 'Taux de cholestérol',
          value: '185',
          date: '10/04/2026',
          unit: 'mg/dL',
          status: 'normal',
        ),
        MedicalRecord(
          id: '2',
          type: 'blood_pressure',
          title: 'Tension artérielle',
          value: '120/80',
          date: '10/04/2026',
          unit: 'mmHg',
          status: 'normal',
        ),
        MedicalRecord(
          id: '3',
          type: 'blood_sugar',
          title: 'Glycémie',
          value: '95',
          date: '08/04/2026',
          unit: 'mg/dL',
          status: 'normal',
        ),
        MedicalRecord(
          id: '4',
          type: 'hemoglobin',
          title: 'Hémoglobine',
          value: '14.2',
          date: '05/04/2026',
          unit: 'g/dL',
          status: 'normal',
        ),
      ];
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String? startDate;
  final String? endDate;
  final bool isActive;

  const Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    this.startDate,
    this.endDate,
    this.isActive = true,
  });

  static List<Medication> mockMedications() => const [
        Medication(
          name: 'Aspirine',
          dosage: '100mg',
          frequency: '1x/jour',
          startDate: '01/01/2026',
          isActive: true,
        ),
        Medication(
          name: 'Diclofenac',
          dosage: '50mg',
          frequency: '2x/jour',
          startDate: '15/03/2026',
          isActive: true,
        ),
        Medication(
          name: 'Oméprazole',
          dosage: '20mg',
          frequency: '1x/jour',
          startDate: '01/02/2026',
          isActive: true,
        ),
      ];
}

class Disease {
  final String name;
  final String type; // chronic, past, allergy
  final String? diagnosedDate;
  final String? notes;

  const Disease({
    required this.name,
    required this.type,
    this.diagnosedDate,
    this.notes,
  });

  static List<Disease> mockDiseases() => const [
        Disease(
          name: 'Asthme',
          type: 'chronic',
          diagnosedDate: '2018',
          notes: 'Léger, contrôlé par traitement',
        ),
        Disease(
          name: 'Allergie au pollen',
          type: 'allergy',
          diagnosedDate: '2015',
        ),
        Disease(
          name: 'Fracture du bras',
          type: 'past',
          diagnosedDate: '2020',
          notes: 'Complètement guéri',
        ),
      ];

  static List<String> mockAllergies() => const [
        'Pollen',
        'Pénicilline',
        'Arachides',
      ];
}
