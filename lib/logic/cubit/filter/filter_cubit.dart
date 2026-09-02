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
    // Tapping the already-selected type deselects it.
    emit(state.copyWith(
      selectedPropertyType: state.selectedPropertyType == type ? null : type,
    ));
  }

  void selectFinishing(String finishing) {
    emit(state.copyWith(
      selectedFinishing: state.selectedFinishing == finishing ? null : finishing,
    ));
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

  void selectMinSize(String value) {
    emit(state.copyWith(minSize: value));
  }

  void selectMaxSize(String value) {
    emit(state.copyWith(maxSize: value));
  }

  void updatePriceRange(RangeValues range) {
    emit(state.copyWith(priceRange: range));
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

  void applyFilters() {
    // TODO: send the current filter selections to your real search/listings API.
  }
}