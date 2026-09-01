import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void selectListingType(String type) {
    emit(state.copyWith(listingType: type));
  }

  void selectLocationMode(String mode) {
    emit(state.copyWith(locationMode: mode));
  }

  void updateLocationQuery(String query) {
    emit(state.copyWith(locationQuery: query));
  }

  void updateDeveloperQuery(String query) {
    emit(state.copyWith(developerQuery: query));
  }

  void toggleCategory(String category) {
    final updated = Set<String>.from(state.selectedCategories);
    updated.contains(category) ? updated.remove(category) : updated.add(category);
    emit(state.copyWith(selectedCategories: updated));
  }

  void selectPropertyType(String type) {
    if (state.selectedPropertyType == type) {
      emit(state.copyWith(clearPropertyType: true));
    } else {
      emit(state.copyWith(selectedPropertyType: type));
    }
  }

  void toggleFinishing(String option) {
    final updated = Set<String>.from(state.selectedFinishing);
    updated.contains(option) ? updated.remove(option) : updated.add(option);
    emit(state.copyWith(selectedFinishing: updated));
  }

  void toggleKeyFeature(String feature) {
    final updated = Set<String>.from(state.selectedKeyFeatures);
    updated.contains(feature) ? updated.remove(feature) : updated.add(feature);
    emit(state.copyWith(selectedKeyFeatures: updated));
  }

  void selectSizeFrom(String? value) {
    emit(state.copyWith(sizeFrom: value, clearSizeFrom: value == null));
  }

  void selectSizeTo(String? value) {
    emit(state.copyWith(sizeTo: value, clearSizeTo: value == null));
  }

  void updatePriceRange(RangeValues values) {
    emit(state.copyWith(priceRange: values));
  }

  void selectPriceMin(String? value) {
    emit(state.copyWith(priceMin: value, clearPriceMin: value == null));
  }

  void selectPriceMax(String? value) {
    emit(state.copyWith(priceMax: value, clearPriceMax: value == null));
  }

  void selectBedrooms(String value) {
    if (state.selectedBedrooms == value) {
      emit(state.copyWith(clearBedrooms: true));
    } else {
      emit(state.copyWith(selectedBedrooms: value));
    }
  }

  void selectRooms(String value) {
    if (state.selectedRooms == value) {
      emit(state.copyWith(clearRooms: true));
    } else {
      emit(state.copyWith(selectedRooms: value));
    }
  }

  void resetAll() {
    emit(const FilterState());
  }


  PropertyFilterResult buildResult() {
    return PropertyFilterResult(
      listingType: state.listingType,
      locationMode: state.locationMode,
      locationQuery: state.locationQuery.trim().isEmpty ? null : state.locationQuery.trim(),
      developer: state.developerQuery.trim().isEmpty ? null : state.developerQuery.trim(),
      categories: state.selectedCategories,
      propertyType: state.selectedPropertyType,
      finishing: state.selectedFinishing,
      keyFeatures: state.selectedKeyFeatures,
      sizeFrom: state.sizeFrom,
      sizeTo: state.sizeTo,
      priceRange: state.priceRange,
      bedrooms: state.selectedBedrooms,
      rooms: state.selectedRooms,
    );
  }
}