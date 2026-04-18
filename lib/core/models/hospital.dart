class Hospital {
  final String id;
  final String name;
  final String address;
  final String city;
  final String region;
  final String phone;
  final String type; // public, private
  final List<String> departments;
  final double rating;
  final bool hasEmergency;

  const Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.region,
    required this.phone,
    required this.type,
    required this.departments,
    required this.rating,
    this.hasEmergency = false,
  });

  static List<Hospital> mockHospitals() => const [
        Hospital(
          id: '1',
          name: 'CHU Hassan II',
          address: 'Route de Sefrou, Fès',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 619 000',
          type: 'Public',
          departments: [
            'Cardiologie',
            'Pédiatrie',
            'Urgences',
            'Chirurgie',
            'Neurologie'
          ],
          rating: 4.3,
          hasEmergency: true,
        ),
        Hospital(
          id: '2',
          name: 'Clinique Al Hayat',
          address: 'Av. des FAR, Fès',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 654 321',
          type: 'Privé',
          departments: ['Pédiatrie', 'Gynécologie', 'Médecine Générale'],
          rating: 4.6,
          hasEmergency: false,
        ),
        Hospital(
          id: '3',
          name: 'Hôpital Ibn Al Hassan',
          address: 'Quartier Zouagha, Fès',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 789 456',
          type: 'Public',
          departments: [
            'Psychiatrie',
            'Neurologie',
            'Médecine Interne',
            'Urgences'
          ],
          rating: 4.1,
          hasEmergency: true,
        ),
        Hospital(
          id: '4',
          name: 'Clinique Les Oliviers',
          address: 'Route de Meknès, Fès',
          city: 'Fès',
          region: 'Fès-Meknès',
          phone: '+212 535 432 109',
          type: 'Privé',
          departments: ['Dermatologie', 'ORL', 'Ophtalmologie'],
          rating: 4.5,
          hasEmergency: false,
        ),
      ];
}
