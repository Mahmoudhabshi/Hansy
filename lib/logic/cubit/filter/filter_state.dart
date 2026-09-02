import 'package:flutter/material.dart';

class FilterState {
  final String listingType; // 'Buy', 'Rent', 'Sale'
  final String locationMode; // 'City', 'Compound'
  final String locationQuery;
  final String developerQuery;
  final Set<String> selectedCategories;
  final String? selectedPropertyType;
  final String? selectedFinishing;
  final Set<String> selectedKeyFeatures;
  final String? minSize;
  final String? maxSize;
  final RangeValues priceRange;
  final String? selectedBedrooms;
  final String? selectedRooms;
  final int resultsCount;

  const FilterState({
    this.listingType = 'Buy',
    this.locationMode = 'City',
    this.locationQuery = '',
    this.developerQuery = '',
    this.selectedCategories = const {},
    this.selectedPropertyType,
    this.selectedFinishing,
    this.selectedKeyFeatures = const {},
    this.minSize,
    this.maxSize,
    this.priceRange = const RangeValues(0, 10000000),
    this.selectedBedrooms,
    this.selectedRooms,
    this.resultsCount = 24, // TODO: replace with a real count from your API once filters are wired to a live query.
  });

  FilterState copyWith({
    String? listingType,
    String? locationMode,
    String? locationQuery,
    String? developerQuery,
    Set<String>? selectedCategories,
    String? selectedPropertyType,
    String? selectedFinishing,
    Set<String>? selectedKeyFeatures,
    String? minSize,
    String? maxSize,
    RangeValues? priceRange,
    String? selectedBedrooms,
    String? selectedRooms,
    int? resultsCount,
  }) {
    return FilterState(
      listingType: listingType ?? this.listingType,
      locationMode: locationMode ?? this.locationMode,
      locationQuery: locationQuery ?? this.locationQuery,
      developerQuery: developerQuery ?? this.developerQuery,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedPropertyType: selectedPropertyType ?? this.selectedPropertyType,
      selectedFinishing: selectedFinishing ?? this.selectedFinishing,
      selectedKeyFeatures: selectedKeyFeatures ?? this.selectedKeyFeatures,
      minSize: minSize ?? this.minSize,
      maxSize: maxSize ?? this.maxSize,
      priceRange: priceRange ?? this.priceRange,
      selectedBedrooms: selectedBedrooms ?? this.selectedBedrooms,
      selectedRooms: selectedRooms ?? this.selectedRooms,
      resultsCount: resultsCount ?? this.resultsCount,
    );
  }
}