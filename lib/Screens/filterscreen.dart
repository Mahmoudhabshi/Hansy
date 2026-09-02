import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/logic/cubit/filter/filter_cubit.dart';
import 'package:hansy/logic/cubit/filter/filter_state.dart';
import 'package:hansy/Screens/appbottomnavbar.dart';
export 'package:hansy/logic/cubit/filter/filter_state.dart' show PropertyFilterResult;

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
  static const List<String> _listingTypes = ['Buy', 'Sell', 'Rent'];
  static const List<String> _locationModes = ['Area', 'Compound'];
  static const List<String> _categoryOptions = [
    'Featured', 'Premium', 'For Rent',
    'For Sale', 'New Listing', 'Hot Deals',
    'Exclusive', 'Nearby', 'Commercial',
    'Residential', 'Affordable',
  ];
  static const List<({String label, IconData icon})> _propertyTypes = [
    (label: 'Apartment', icon: Icons.apartment),
    (label: 'Duplex', icon: Icons.home_outlined),
    (label: 'Pent House', icon: Icons.holiday_village_outlined),
    (label: 'Villa', icon: Icons.villa_outlined),
    (label: 'Townhouse', icon: Icons.other_houses_outlined),
    (label: 'Studio', icon: Icons.apartment_outlined),
    (label: 'Office', icon: Icons.business_outlined),
    (label: 'House', icon: Icons.house_outlined),
  ];
  static const List<String> _finishingOptions = [
    'Not Finished', 'Semi-Finished', 'Finished', 'Furnished', 'Semi-Furnished',
  ];
  static const List<({String label, IconData icon})> _keyFeatureOptions = [
    (label: 'Storage', icon: Icons.inventory_2_outlined),
    (label: 'Hospital', icon: Icons.local_hospital_outlined),
    (label: 'Delivery', icon: Icons.delivery_dining_outlined),
    (label: 'Restaurant', icon: Icons.restaurant_outlined),
    (label: 'Parking', icon: Icons.local_parking_outlined),
  ];
  static const List<String> _sizeOptions = ['50 m²', '100 m²', '150 m²', '200 m²', '300 m²+'];
  static const List<String> _priceMinOptions = ['\$0', '\$5000', '\$10000', '\$20000'];
  static const List<String> _priceMaxOptions = ['\$20000', '\$30000', '\$40000', '\$50000'];
  static const List<String> _bedroomOptions = ['1', '2', '3', '4', '5', '+'];
  static const List<String> _roomOptions = ['1', '2', '3', '4', '5', '+'];

  static const double _priceMin = 0;
  static const double _priceMax = 50000;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();
  int _currentNavIndex = 0;

  @override
  void dispose() {
    _locationController.dispose();
    _developerController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) => setState(() => _currentNavIndex = index);

  void _onWhatsappTap() {
    // TODO: launch WhatsApp / support chat.
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    return Scaffold(
      backgroundColor: AppColors.iconCircleBg,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Filter',
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          // Keep text controllers in sync if resetAll() clears the state.
          if (_locationController.text != state.locationQuery) {
            _locationController.value = _locationController.value.copyWith(text: state.locationQuery);
          }
          if (_developerController.text != state.developerQuery) {
            _developerController.value = _developerController.value.copyWith(text: state.developerQuery);
          }

          return SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ListingTypeTabs(
                          types: _listingTypes,
                          selected: state.listingType,
                          onSelected: cubit.selectListingType,
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Location',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: _locationModes.map((mode) {
                                  final isSelected = mode == state.locationMode;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: _PillToggle(
                                      label: mode,
                                      icon: mode == 'Area' ? Icons.place_outlined : Icons.apartment,
                                      isSelected: isSelected,
                                      onTap: () => cubit.selectLocationMode(mode),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 12),
                              _SearchField(
                                controller: _locationController,
                                hint: 'e.g. New Cairo, Zayed, etc.',
                                onChanged: cubit.updateLocationQuery,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Developer',
                          child: _SearchField(
                            controller: _developerController,
                            hint: 'Search Developer',
                            onChanged: cubit.updateDeveloperQuery,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Category',
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _categoryOptions.map((label) {
                              final isSelected = state.selectedCategories.contains(label);
                              return _ChoiceChip(
                                label: label,
                                isSelected: isSelected,
                                onTap: () => cubit.toggleCategory(label),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text('Property Type', style: _sectionTitleStyle),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.85,
                          children: _propertyTypes.map((type) {
                            final isSelected = type.label == state.selectedPropertyType;
                            return _PropertyTypeTile(
                              label: type.label,
                              icon: type.icon,
                              isSelected: isSelected,
                              onTap: () => cubit.selectPropertyType(type.label),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Finishing',
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _finishingOptions.map((label) {
                              final isSelected = state.selectedFinishing.contains(label);
                              return _ChoiceChip(
                                label: label,
                                isSelected: isSelected,
                                onTap: () => cubit.toggleFinishing(label),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Key Features',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: _keyFeatureOptions.map((feature) {
                                  final isSelected = state.selectedKeyFeatures.contains(feature.label);
                                  return _ChoiceChip(
                                    label: feature.label,
                                    icon: feature.icon,
                                    isSelected: isSelected,
                                    onTap: () => cubit.toggleKeyFeature(feature.label),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Select all that apply to your property',
                                style: TextStyle(fontSize: 11, color: AppColors.textGrey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Property Size',
                          child: Row(
                            children: [
                              Expanded(
                                child: _Dropdown(
                                  hint: 'From',
                                  value: state.sizeFrom,
                                  options: _sizeOptions,
                                  onChanged: cubit.selectSizeFrom,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _Dropdown(
                                  hint: 'To',
                                  value: state.sizeTo,
                                  options: _sizeOptions,
                                  onChanged: cubit.selectSizeTo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Price Range',
                          child: Column(
                            children: [
                              RangeSlider(
                                values: state.priceRange,
                                min: _priceMin,
                                max: _priceMax,
                                activeColor: AppColors.submitRed,
                                inactiveColor: AppColors.inputBorder,
                                onChanged: cubit.updatePriceRange,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('\$${state.priceRange.start.round()}', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                                    Text('\$${state.priceRange.end.round()}', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: _Dropdown(
                                      hint: 'Min',
                                      value: state.priceMin,
                                      options: _priceMinOptions,
                                      onChanged: cubit.selectPriceMin,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _Dropdown(
                                      hint: 'Max',
                                      value: state.priceMax,
                                      options: _priceMaxOptions,
                                      onChanged: cubit.selectPriceMax,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Bedrooms',
                          child: _NumberSelectorRow(
                            options: _bedroomOptions,
                            selected: state.selectedBedrooms,
                            onSelected: cubit.selectBedrooms,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _FilterCard(
                          title: 'Rooms',
                          child: _NumberSelectorRow(
                            options: _roomOptions,
                            selected: state.selectedRooms,
                            onSelected: cubit.selectRooms,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom action bar
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, -2)),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: cubit.resetAll,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.submitRed),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(
                                'Reset All',
                                style: TextStyle(color: AppColors.submitRed, fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(cubit.buildResult()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.submitRed,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text(
                                    'Show All Results',
                                    style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -6,
                                top: -6,
                                bottom: -6,
                                child: GestureDetector(
                                  onTap: _onWhatsappTap,
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                                    child: const Icon(Icons.chat, color: Color(0xFF25D366), size: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

const TextStyle _sectionTitleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: AppColors.black,
);

/// ---------------------------------------------------------------------
/// Shared building blocks
/// ---------------------------------------------------------------------

class _FilterCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _sectionTitleStyle),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ListingTypeTabs extends StatelessWidget {
  final List<String> types;
  final String selected;
  final ValueChanged<String> onSelected;

  const _ListingTypeTabs({required this.types, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: types.map((type) {
          final isSelected = type == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.submitRed : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.white : AppColors.textGrey,
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

class _PillToggle extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PillToggle({required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.iconCircleBg,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isSelected ? AppColors.white : AppColors.textGrey),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textGrey,
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
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.placeholderGrey, fontSize: 13),
          prefixIcon: Icon(Icons.search, color: AppColors.placeholderGrey, size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceChip({required this.label, this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.iconCircleBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: isSelected ? AppColors.white : AppColors.textGrey),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyTypeTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PropertyTypeTile({required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.submitRed : AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: isSelected ? AppColors.white : AppColors.submitRed),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
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
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _Dropdown({required this.hint, required this.value, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: AppColors.placeholderGrey, fontSize: 13)),
          icon: Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: 18),
          items: options
              .map((option) => DropdownMenuItem(value: option, child: Text(option, style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _NumberSelectorRow extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String> onSelected;

  const _NumberSelectorRow({required this.options, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final isSelected = option == selected;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.submitRed : AppColors.iconCircleBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.white : AppColors.textDark,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}