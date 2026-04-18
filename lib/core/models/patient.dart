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
  });

  String get fullName => '$firstName $lastName';

  static Patient mock() => const Patient(
        id: '1',
        cin: 'AB123456',
        firstName: 'Yassine',
        lastName: 'El Amrani',
        dateOfBirth: '15/03/1995',
        bloodType: 'A+',
        weight: 72.5,
        height: 175,
        avatarUrl: null,
      );
}
