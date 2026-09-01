import 'package:flutter/material.dart';
import 'package:hansy/theme/constant.dart';


class PropertyFilterResult {
  final String listingType;
  final String locationMode;
  final String? locationQuery;
  final String? developer;
  final Set<String> categories;
  final String? propertyType;
  final Set<String> finishing;
  final Set<String> keyFeatures;
  final String? sizeFrom;
  final String? sizeTo;
  final RangeValues priceRange;
  final String? bedrooms;
  final String? rooms;

  const PropertyFilterResult({
    required this.listingType,
    required this.locationMode,
    this.locationQuery,
    this.developer,
    required this.categories,
    this.propertyType,
    required this.finishing,
    required this.keyFeatures,
    this.sizeFrom,
    this.sizeTo,
    required this.priceRange,
    this.bedrooms,
    this.rooms,
  });
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
  static const List<String> _bedroomOptions = ['1', '2', '3', '4', '5', '+'];
  static const List<String> _roomOptions = ['1', '2', '3', '4', '5', '+'];

  String _selectedListingType = 'Buy';
  String _selectedLocationMode = 'Area';
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _developerController = TextEditingController();

  final Set<String> _selectedCategories = {};
  String? _selectedPropertyType = 'Apartment';
  final Set<String> _selectedFinishing = {};
  final Set<String> _selectedKeyFeatures = {};

  String? _sizeFrom;
  String? _sizeTo;

  RangeValues _priceRange = const RangeValues(3000, 30000);
  static const double _priceMin = 0;
  static const double _priceMax = 50000;

  String? _selectedBedrooms;
  String? _selectedRooms;

  @override
  void dispose() {
    _locationController.dispose();
    _developerController.dispose();
    super.dispose();
  }

  void _onResetAll() {
    setState(() {
      _selectedListingType = 'Buy';
      _selectedLocationMode = 'Area';
      _locationController.clear();
      _developerController.clear();
      _selectedCategories.clear();
      _selectedPropertyType = null;
      _selectedFinishing.clear();
      _selectedKeyFeatures.clear();
      _sizeFrom = null;
      _sizeTo = null;
      _priceRange = const RangeValues(3000, 30000);
      _selectedBedrooms = null;
      _selectedRooms = null;
    });
  }

  void _onShowResults() {
    final result = PropertyFilterResult(
      listingType: _selectedListingType,
      locationMode: _selectedLocationMode,
      locationQuery: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
      developer: _developerController.text.trim().isEmpty ? null : _developerController.text.trim(),
      categories: _selectedCategories,
      propertyType: _selectedPropertyType,
      finishing: _selectedFinishing,
      keyFeatures: _selectedKeyFeatures,
      sizeFrom: _sizeFrom,
      sizeTo: _sizeTo,
      priceRange: _priceRange,
      bedrooms: _selectedBedrooms,
      rooms: _selectedRooms,
    );
    Navigator.of(context).pop(result);
  }

  void _onWhatsappTap() {
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
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
                      selected: _selectedListingType,
                      onSelected: (value) => setState(() => _selectedListingType = value),
                    ),
                    const SizedBox(height: 16),

                    _FilterCard(
                      title: 'Location',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: _locationModes.map((mode) {
                              final isSelected = mode == _selectedLocationMode;
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: _PillToggle(
                                  label: mode,
                                  icon: mode == 'Area' ? Icons.place_outlined : Icons.apartment,
                                  isSelected: isSelected,
                                  onTap: () => setState(() => _selectedLocationMode = mode),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),
                          _SearchField(
                            controller: _locationController,
                            hint: 'e.g. New Cairo, Zayed, etc.',
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
                      ),
                    ),
                    const SizedBox(height: 16),

                    _FilterCard(
                      title: 'Category',
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categoryOptions.map((label) {
                          final isSelected = _selectedCategories.contains(label);
                          return _ChoiceChip(
                            label: label,
                            isSelected: isSelected,
                            onTap: () => setState(() {
                              isSelected ? _selectedCategories.remove(label) : _selectedCategories.add(label);
                            }),
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
                        final isSelected = type.label == _selectedPropertyType;
                        return _PropertyTypeTile(
                          label: type.label,
                          icon: type.icon,
                          isSelected: isSelected,
                          onTap: () => setState(() => _selectedPropertyType = type.label),
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
                          final isSelected = _selectedFinishing.contains(label);
                          return _ChoiceChip(
                            label: label,
                            isSelected: isSelected,
                            onTap: () => setState(() {
                              isSelected ? _selectedFinishing.remove(label) : _selectedFinishing.add(label);
                            }),
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
                              final isSelected = _selectedKeyFeatures.contains(feature.label);
                              return _ChoiceChip(
                                label: feature.label,
                                icon: feature.icon,
                                isSelected: isSelected,
                                onTap: () => setState(() {
                                  isSelected
                                      ? _selectedKeyFeatures.remove(feature.label)
                                      : _selectedKeyFeatures.add(feature.label);
                                }),
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
                              value: _sizeFrom,
                              options: _sizeOptions,
                              onChanged: (value) => setState(() => _sizeFrom = value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _Dropdown(
                              hint: 'To',
                              value: _sizeTo,
                              options: _sizeOptions,
                              onChanged: (value) => setState(() => _sizeTo = value),
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
                            values: _priceRange,
                            min: _priceMin,
                            max: _priceMax,
                            activeColor: AppColors.submitRed,
                            inactiveColor: AppColors.inputBorder,
                            onChanged: (values) => setState(() => _priceRange = values),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$${_priceRange.start.round()}', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                                Text('\$${_priceRange.end.round()}', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _Dropdown(
                                  hint: 'Min',
                                  value: null,
                                  options: const ['\$0', '\$5000', '\$10000', '\$20000'],
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _Dropdown(
                                  hint: 'Max',
                                  value: null,
                                  options: const ['\$20000', '\$30000', '\$40000', '\$50000'],
                                  onChanged: (value) {},
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
                        selected: _selectedBedrooms,
                        onSelected: (value) => setState(() => _selectedBedrooms = value),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _FilterCard(
                      title: 'Rooms',
                      child: _NumberSelectorRow(
                        options: _roomOptions,
                        selected: _selectedRooms,
                        onSelected: (value) => setState(() => _selectedRooms = value),
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
                          onPressed: _onResetAll,
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
                              onPressed: _onShowResults,
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
      ),
    );
  }
}

const TextStyle _sectionTitleStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: AppColors.black,
);



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

  const _SearchField({required this.controller, required this.hint});

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