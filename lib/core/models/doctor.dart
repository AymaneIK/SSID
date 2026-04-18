class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final String city;
  final String region;
  final String phone;
  final double rating;
  final bool isAvailable;
  final String? avatarUrl;
  final String schedule;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.city,
    required this.region,
    required this.phone,
    required this.rating,
    this.isAvailable = true,
    this.avatarUrl,
    required this.schedule,
  });

  static List<Doctor> mockDoctors() => const [
        Doctor(
          id: '1',
          name: 'Dr. Ahmed Benali',
          specialty: 'Cardiologue',
          hospital: 'CHU Hassan II',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 123 456',
          rating: 4.8,
          schedule: 'Lun-Ven: 8h-16h',
        ),
        Doctor(
          id: '2',
          name: 'Dr. Fatima Zahra',
          specialty: 'Pédiatre',
          hospital: 'Clinique Al Hayat',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 789 012',
          rating: 4.9,
          schedule: 'Lun-Sam: 9h-17h',
        ),
        Doctor(
          id: '3',
          name: 'Dr. Karim Idrissi',
          specialty: 'Gastro-entérologue',
          hospital: 'CHU Hassan II',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 345 678',
          rating: 4.6,
          schedule: 'Mar-Sam: 8h-15h',
        ),
        Doctor(
          id: '4',
          name: 'Dr. Salma Berrada',
          specialty: 'Nutritionniste',
          hospital: 'Cabinet Privé',
          city: 'Meknès',
          region: 'Fès-Meknès',
          phone: '+212 535 901 234',
          rating: 4.7,
          schedule: 'Lun-Ven: 10h-18h',
        ),
        Doctor(
          id: '5',
          name: 'Dr. Youssef Tazi',
          specialty: 'Psychiatre',
          hospital: 'Hôpital Ibn Al Hassan',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 567 890',
          rating: 4.5,
          schedule: 'Lun-Jeu: 9h-16h',
        ),
        Doctor(
          id: '6',
          name: 'Dr. Nadia Amrani',
          specialty: 'Dermatologue',
          hospital: 'Clinique Les Oliviers',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 234 567',
          rating: 4.8,
          schedule: 'Lun-Ven: 8h30-17h',
        ),
      ];
}
