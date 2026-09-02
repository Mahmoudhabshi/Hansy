import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/appbottomnavbar.dart';
import 'package:hansy/logic/cubit/filter/filter_cubit.dart';
import 'package:hansy/logic/cubit/filter/filter_state.dart';

// Static option lists. Move these to your Cubit/repository once they come
// from a real API (categories, property types, etc. are often dynamic).
const _listingTypes = ['Buy', 'Rent', 'Sale'];

const _categories = [
  'Featured', 'Premium', 'For Rent', 'For Sale', 'New Listing',
  'Hot Deals', 'Exclusive', 'Nearly Ready', 'Commercial', 'Resale',
];

const _propertyTypes = [
  (label: 'Apartment', icon: Icons.apartment),
  (label: 'Duplex', icon: Icons.house_siding),
  (label: 'Penthouse', icon: Icons.villa),
  (label: 'Villa', icon: Icons.villa_outlined),
  (label: 'Townhouse', icon: Icons.holiday_village),
  (label: 'Studio', icon: Icons.meeting_room_outlined),
  (label: 'Office', icon: Icons.business_center_outlined),
  (label: 'Chalet', icon: Icons.cottage_outlined),
  (label: 'House', icon: Icons.home_outlined),
];

const _finishingOptions = ['Not Finished', 'Semi-Finished', 'Finished', 'Furnished', 'Fully Furnished'];

const _keyFeatures = [
  (label: 'Pool', icon: Icons.pool),
  (label: 'Hospital', icon: Icons.local_hospital_outlined),
  (label: 'Delivery', icon: Icons.local_shipping_outlined),
  (label: 'Security', icon: Icons.security),
  (label: 'Parking', icon: Icons.local_parking_outlined),
];

const _sizeOptions = ['Any', '50', '100', '150', '200', '300', '400', '500+'];
const _numberOptions = ['1', '2', '3', '4', '5+'];

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: const _FilterView(),
    );
  }
}

class _FilterView extends StatefulWidget {
  const _FilterView();

  @override
  State<_FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<_FilterView> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();
  int _currentNavIndex = 0;

  @override
  void dispose() {
    _locationController.dispose();
    _developerController.dispose();
    super.dispose();
  }

  void _onWhatsappTap() {}
  void _onNavTap(int index) => setState(() => _currentNavIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.black,
        centerTitle: true,
        title: const Text('Filter', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          final cubit = context.read<FilterCubit>();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ListingTypeTabs(
                        selected: state.listingType,
                        onSelected: cubit.selectListingType,
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Location'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _LocationModeChip(
                            label: 'City',
                            isSelected: state.locationMode == 'City',
                            onTap: () => cubit.selectLocationMode('City'),
                          ),
                          const SizedBox(width: 10),
                          _LocationModeChip(
                            label: 'Compound',
                            isSelected: state.locationMode == 'Compound',
                            onTap: () => cubit.selectLocationMode('Compound'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _SearchField(
                        controller: _locationController,
                        hint: 'e.g. New Cairo, Sheikh Zayed, etc',
                        onChanged: cubit.updateLocationQuery,
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Developer'),
                      const SizedBox(height: 10),
                      _SearchField(
                        controller: _developerController,
                        hint: 'Search Developer',
                        onChanged: cubit.updateDeveloperQuery,
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Category'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categories.map((category) {
                          final isSelected = state.selectedCategories.contains(category);
                          return _FilterChip(
                            label: category,
                            isSelected: isSelected,
                            onTap: () => cubit.toggleCategory(category),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Property Type'),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                        children: _propertyTypes.map((type) {
                          final isSelected = state.selectedPropertyType == type.label;
                          return _PropertyTypeButton(
                            label: type.label,
                            icon: type.icon,
                            isSelected: isSelected,
                            onTap: () => cubit.selectPropertyType(type.label),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Finishing'),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _finishingOptions.map((finishing) {
                          final isSelected = state.selectedFinishing == finishing;
                          return _FilterChip(
                            label: finishing,
                            isSelected: isSelected,
                            onTap: () => cubit.selectFinishing(finishing),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Key Features'),
                      const SizedBox(height: 4),
                      Text(
                        'Select all that apply to your property',
                        style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _keyFeatures.map((feature) {
                          final isSelected = state.selectedKeyFeatures.contains(feature.label);
                          return _KeyFeatureChip(
                            label: feature.label,
                            icon: feature.icon,
                            isSelected: isSelected,
                            onTap: () => cubit.toggleKeyFeature(feature.label),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Property Size'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _Dropdown(
                              value: state.minSize ?? 'Any',
                              hint: 'Min',
                              options: _sizeOptions,
                              onChanged: cubit.selectMinSize,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _Dropdown(
                              value: state.maxSize ?? 'Any',
                              hint: 'Max',
                              options: _sizeOptions,
                              onChanged: cubit.selectMaxSize,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Price Range'),
                      const SizedBox(height: 4),
                      RangeSlider(
                        values: state.priceRange,
                        min: 0,
                        max: 10000000,
                        divisions: 100,
                        activeColor: AppColors.submitRed,
                        inactiveColor: AppColors.inputBorder,
                        labels: RangeLabels(
                          state.priceRange.start.round().toString(),
                          state.priceRange.end.round().toString(),
                        ),
                        onChanged: cubit.updatePriceRange,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.priceRange.start.round().toString(), style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                          Text(state.priceRange.end.round().toString(), style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Bedrooms'),
                      const SizedBox(height: 10),
                      Row(
                        children: _numberOptions.map((value) {
                          final isSelected = state.selectedBedrooms == value;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _NumberChip(
                              label: value,
                              isSelected: isSelected,
                              onTap: () => cubit.selectBedrooms(value),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      const _SectionTitle('Rooms'),
                      const SizedBox(height: 10),
                      Row(
                        children: _numberOptions.map((value) {
                          final isSelected = state.selectedRooms == value;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _NumberChip(
                              label: value,
                              isSelected: isSelected,
                              onTap: () => cubit.selectRooms(value),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom action bar: Reset All / Show All (count)
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: cubit.resetAll,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.inputBorder),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Reset All', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: cubit.applyFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.submitRed,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Show All (${state.resultsCount})', style: AppTextStyles.buttonLabel),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: -22,
                    child: GestureDetector(
                      onTap: _onWhatsappTap,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(color: Color(0xFF25D366), shape: BoxShape.circle),
                        child: const Icon(Icons.chat, color: AppColors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.black));
  }
}

class _ListingTypeTabs extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const _ListingTypeTabs({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.iconCircleBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: _listingTypes.map((type) {
          final isSelected = selected == type;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(type),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.submitRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LocationModeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LocationModeChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? AppColors.submitRed : AppColors.inputBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_outlined, size: 16, color: isSelected ? AppColors.white : AppColors.textGrey),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.placeholderGrey, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: AppColors.placeholderGrey, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.submitRed : AppColors.inputBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}

class _PropertyTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PropertyTypeButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.submitRed : AppColors.inputBorder),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? AppColors.white : AppColors.submitRed, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyFeatureChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _KeyFeatureChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.submitRed : AppColors.inputBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: isSelected ? AppColors.white : AppColors.submitRed),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String value;
  final String hint;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _Dropdown({required this.value, required this.hint, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
          hint: Text(hint, style: TextStyle(color: AppColors.placeholderGrey, fontSize: 13)),
          style: TextStyle(color: AppColors.textDark, fontSize: 13),
          items: options.map((option) {
            return DropdownMenuItem(value: option, child: Text(option));
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) onChanged(newValue);
          },
        ),
      ),
    );
  }
}

class _NumberChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NumberChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? AppColors.submitRed : AppColors.inputBorder),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isSelected ? AppColors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}