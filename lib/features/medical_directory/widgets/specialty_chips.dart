import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SpecialtyChips extends StatelessWidget {
  final List<String> specialties;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const SpecialtyChips({
    super.key,
    required this.specialties,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final isSelected = specialty == selected;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 4,
              right: 4,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: FilterChip(
                label: Text(
                  specialty,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : AppColors.textPrimary,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                selected: isSelected,
                onSelected: (val) {
                  onSelected(val ? specialty : null);
                },
                backgroundColor: AppColors.surface,
                selectedColor: AppColors.primary,
                checkmarkColor: Colors.white,
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.divider,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                elevation: isSelected ? 2 : 0,
                pressElevation: 0,
                shadowColor: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
          );
        },
      ),
    );
  }
}
