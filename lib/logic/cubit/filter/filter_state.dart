import 'package:flutter/material.dart';


class FilterState {
  final String listingType;
  final String locationMode;
  final String locationQuery;
  final String developerQuery;

  final Set<String> selectedCategories;
  final String? selectedPropertyType;
  final Set<String> selectedFinishing;
  final Set<String> selectedKeyFeatures;

  final String? sizeFrom;
  final String? sizeTo;

  final RangeValues priceRange;
  final String? priceMin;
  final String? priceMax;

  final String? selectedBedrooms;
  final String? selectedRooms;

  const FilterState({
    this.listingType = 'Buy',
    this.locationMode = 'Area',
    this.locationQuery = '',
    this.developerQuery = '',
    this.selectedCategories = const {},
    this.selectedPropertyType,
    this.selectedFinishing = const {},
    this.selectedKeyFeatures = const {},
    this.sizeFrom,
    this.sizeTo,
    this.priceRange = const RangeValues(3000, 30000),
    this.priceMin,
    this.priceMax,
    this.selectedBedrooms,
    this.selectedRooms,
  });

  FilterState copyWith({
    String? listingType,
    String? locationMode,
    String? locationQuery,
    String? developerQuery,
    Set<String>? selectedCategories,
    String? selectedPropertyType,
    bool clearPropertyType = false,
    Set<String>? selectedFinishing,
    Set<String>? selectedKeyFeatures,
    String? sizeFrom,
    bool clearSizeFrom = false,
    String? sizeTo,
    bool clearSizeTo = false,
    RangeValues? priceRange,
    String? priceMin,
    bool clearPriceMin = false,
    String? priceMax,
    bool clearPriceMax = false,
    String? selectedBedrooms,
    bool clearBedrooms = false,
    String? selectedRooms,
    bool clearRooms = false,
  }) {
    return FilterState(
      listingType: listingType ?? this.listingType,
      locationMode: locationMode ?? this.locationMode,
      locationQuery: locationQuery ?? this.locationQuery,
      developerQuery: developerQuery ?? this.developerQuery,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedPropertyType: clearPropertyType ? null : (selectedPropertyType ?? this.selectedPropertyType),
      selectedFinishing: selectedFinishing ?? this.selectedFinishing,
      selectedKeyFeatures: selectedKeyFeatures ?? this.selectedKeyFeatures,
      sizeFrom: clearSizeFrom ? null : (sizeFrom ?? this.sizeFrom),
      sizeTo: clearSizeTo ? null : (sizeTo ?? this.sizeTo),
      priceRange: priceRange ?? this.priceRange,
      priceMin: clearPriceMin ? null : (priceMin ?? this.priceMin),
      priceMax: clearPriceMax ? null : (priceMax ?? this.priceMax),
      selectedBedrooms: clearBedrooms ? null : (selectedBedrooms ?? this.selectedBedrooms),
      selectedRooms: clearRooms ? null : (selectedRooms ?? this.selectedRooms),
    );
  }
}


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