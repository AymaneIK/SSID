import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/models/doctor.dart';
import '../../core/models/hospital.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/specialty_chips.dart';
import 'widgets/doctor_card.dart';
import 'widgets/hospital_card.dart';
import 'screens/map_detail_page.dart';

class MedicalDirectoryPage extends StatefulWidget {
  const MedicalDirectoryPage({super.key});

  @override
  State<MedicalDirectoryPage> createState() => _MedicalDirectoryPageState();
}

class _MedicalDirectoryPageState extends State<MedicalDirectoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedSpecialty;
  String? _selectedRegion = 'Fès-Meknès'; // Default
  String _searchQuery = '';

  final specialties = [
    'Tous',
    'Cardiologie',
    'Pédiatrie',
    'Gastro',
    'Nutrition',
    'Psychiatrie',
    'Dermatologie',
    'Neurologie',
    'ORL',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Doctor> get _filteredDoctors {
    var doctors = Doctor.mockDoctors();
    if (_searchQuery.isNotEmpty) {
      doctors = doctors
          .where((d) =>
              d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              d.specialty
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              d.hospital
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    if (_selectedRegion != null) {
      doctors = doctors
          .where((d) =>
              d.region.toLowerCase() == _selectedRegion!.toLowerCase())
          .toList();
    }
    return doctors;
  }

  List<Hospital> get _filteredHospitals {
    var hospitals = Hospital.mockHospitals();
    if (_searchQuery.isNotEmpty) {
      hospitals = hospitals
          .where((h) =>
              h.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              h.address
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              h.departments.any((d) =>
                  d.toLowerCase().contains(_searchQuery.toLowerCase())))
          .toList();
    }
    if (_selectedRegion != null) {
      hospitals = hospitals
          .where((h) => h.region.toLowerCase() == _selectedRegion!.toLowerCase())
          .toList();
    }
    return hospitals;
  }

  void _showRegionPicker() {
    final regions = [
      'Tanger-Tétouan-Al Hoceïma',
      'L\'Oriental',
      'Fès-Meknès',
      'Rabat-Salé-Kénitra',
      'Béni Mellal-Khénifra',
      'Casablanca-Settat',
      'Marrakech-Safi',
      'Drâa-Tafilalet',
      'Souss-Massa',
      'Guelmim-Oued Noun',
      'Laâyoune-Sakia El Hamra',
      'Dakhla-Oued Ed Dahab',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Text('Choisir une région', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(regions[index]),
                    onTap: () {
                      setState(() {
                        _selectedRegion = regions[index];
                      }); 
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
                       Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  const SizedBox(width: 42), // Spacer to center title
                  const Spacer(),
                  Text(
                    'Répertoire médical',
                    style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                               fontWeight: FontWeight.w700,
                             ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapDetailPage(
                            locationName: 'Tous les établissements',
                            address: 'Diverses localisations au Maroc',
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
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
                        Icons.map_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),

            const SizedBox(height: 16),

            // Region selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: _showRegionPicker,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _selectedRegion ?? 'Choisir une région',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Specialty chips
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SpecialtyChips(
                specialties: specialties,
                selected: _selectedSpecialty,
                onSelected: (value) {
                  setState(() => _selectedSpecialty = value);
                },
              ),
            ),

            const SizedBox(height: 16),

            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TabBar(
                  controller: _tabController,
                  onTap: (_) => setState(() {}),
                  indicator: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.textPrimary,
                  unselectedLabelColor: AppColors.textTertiary,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: 'Médecins'),
                    Tab(text: 'Hôpitaux'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Results count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    _tabController.index == 0
                        ? '${_filteredDoctors.length} médecins trouvés'
                        : '${_filteredHospitals.length} hôpitaux trouvés',
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.sort_rounded,
                    color: AppColors.textTertiary,
                    size: 20,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Doctors Tab
                  _filteredDoctors.isEmpty
                      ? _buildEmptyState(context, 'Aucun médecin trouvé')
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _filteredDoctors.length,
                          itemBuilder: (context, index) {
                            return DoctorCard(
                              doctor: _filteredDoctors[index],
                            );
                          },
                        ),

                  // Hospitals Tab
                  _filteredHospitals.isEmpty
                      ? _buildEmptyState(
                          context, 'Aucun hôpital trouvé')
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: _filteredHospitals.length,
                          itemBuilder: (context, index) {
                            return HospitalCard(
                              hospital: _filteredHospitals[index],
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: AppColors.textTertiary,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez de modifier vos critères de recherche',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
