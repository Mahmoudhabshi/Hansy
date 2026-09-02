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
    if (updated.contains(category)) {
      updated.remove(category);
    } else {
      updated.add(category);
    }
    emit(state.copyWith(selectedCategories: updated));
  }

  void selectPropertyType(String type) {
    emit(state.copyWith(
      selectedPropertyType: state.selectedPropertyType == type ? null : type,
    ));
  }

  void toggleFinishing(String finishing) {
    final updated = Set<String>.from(state.selectedFinishing);
    if (updated.contains(finishing)) {
      updated.remove(finishing);
    } else {
      updated.add(finishing);
    }
    emit(state.copyWith(selectedFinishing: updated));
  }

  void toggleKeyFeature(String feature) {
    final updated = Set<String>.from(state.selectedKeyFeatures);
    if (updated.contains(feature)) {
      updated.remove(feature);
    } else {
      updated.add(feature);
    }
    emit(state.copyWith(selectedKeyFeatures: updated));
  }

  void selectSizeFrom(String? value) {
    if (value == null) return;
    emit(state.copyWith(sizeFrom: value));
  }

  void selectSizeTo(String? value) {
    if (value == null) return;
    emit(state.copyWith(sizeTo: value));
  }

  void updatePriceRange(RangeValues range) {
    emit(state.copyWith(priceRange: range));
  }

  void selectPriceMin(String? value) {
    if (value == null) return;
    emit(state.copyWith(priceMin: value));
  }

  void selectPriceMax(String? value) {
    if (value == null) return;
    emit(state.copyWith(priceMax: value));
  }

  void selectBedrooms(String value) {
    emit(state.copyWith(
      selectedBedrooms: state.selectedBedrooms == value ? null : value,
    ));
  }

  void selectRooms(String value) {
    emit(state.copyWith(
      selectedRooms: state.selectedRooms == value ? null : value,
    ));
  }

  void resetAll() {
    emit(const FilterState());
  }

  PropertyFilterResult buildResult() {
    return PropertyFilterResult.fromState(state);
  }
}