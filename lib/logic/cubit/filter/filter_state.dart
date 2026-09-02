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
  final int resultsCount;

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
    this.priceRange = const RangeValues(0, 50000),
    this.priceMin,
    this.priceMax,
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
    Set<String>? selectedFinishing,
    Set<String>? selectedKeyFeatures,
    String? sizeFrom,
    String? sizeTo,
    RangeValues? priceRange,
    String? priceMin,
    String? priceMax,
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
      sizeFrom: sizeFrom ?? this.sizeFrom,
      sizeTo: sizeTo ?? this.sizeTo,
      priceRange: priceRange ?? this.priceRange,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      selectedBedrooms: selectedBedrooms ?? this.selectedBedrooms,
      selectedRooms: selectedRooms ?? this.selectedRooms,
      resultsCount: resultsCount ?? this.resultsCount,
    );
  }
}

/// A snapshot of the user's filter selections, returned by
/// [FilterCubit.buildResult] when they tap "Show All Results".
/// Pass this to your listings/search screen to actually query with it.
class PropertyFilterResult {
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

  const PropertyFilterResult({
    required this.listingType,
    required this.locationMode,
    required this.locationQuery,
    required this.developerQuery,
    required this.selectedCategories,
    required this.selectedPropertyType,
    required this.selectedFinishing,
    required this.selectedKeyFeatures,
    required this.sizeFrom,
    required this.sizeTo,
    required this.priceRange,
    required this.priceMin,
    required this.priceMax,
    required this.selectedBedrooms,
    required this.selectedRooms,
  });

  factory PropertyFilterResult.fromState(FilterState state) {
    return PropertyFilterResult(
      listingType: state.listingType,
      locationMode: state.locationMode,
      locationQuery: state.locationQuery,
      developerQuery: state.developerQuery,
      selectedCategories: state.selectedCategories,
      selectedPropertyType: state.selectedPropertyType,
      selectedFinishing: state.selectedFinishing,
      selectedKeyFeatures: state.selectedKeyFeatures,
      sizeFrom: state.sizeFrom,
      sizeTo: state.sizeTo,
      priceRange: state.priceRange,
      priceMin: state.priceMin,
      priceMax: state.priceMax,
      selectedBedrooms: state.selectedBedrooms,
      selectedRooms: state.selectedRooms,
    );
  }
}