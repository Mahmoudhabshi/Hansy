import 'package:flutter/material.dart';

@immutable
class CategoryItem {
  final String label;
  final String imagePath;

  const CategoryItem({required this.label, required this.imagePath});
}

@immutable
class PromoBanner {
  final String title;
  final String subtitle;
  final String buttonLabel;

  const PromoBanner({
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
  });
}

@immutable
class InfoCardItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoCardItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

@immutable
class PropertyItem {
  final String id;
  final String imagePath;
  final String price;
  final String title;
  final String location;
  final String type;
  final int beds;
  final int baths;
  final String area;
  final String? agentPhone;
  final String? agentWhatsapp;
  final bool isFavorite;

  const PropertyItem({
    required this.id,
    required this.imagePath,
    required this.price,
    required this.title,
    required this.location,
    required this.type,
    required this.beds,
    required this.baths,
    required this.area,
    this.agentPhone,
    this.agentWhatsapp,
    this.isFavorite = false,
  });

  PropertyItem copyWith({bool? isFavorite}) {
    return PropertyItem(
      id: id,
      imagePath: imagePath,
      price: price,
      title: title,
      location: location,
      type: type,
      beds: beds,
      baths: baths,
      area: area,
      agentPhone: agentPhone,
      agentWhatsapp: agentWhatsapp,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@immutable
class DeveloperItem {
  final String name;
  final String logoPath;

  const DeveloperItem({required this.name, required this.logoPath});
}

@immutable
class CompoundItem {
  final String name;
  final String imagePath;
  final int propertiesCount;

  const CompoundItem({
    required this.name,
    required this.imagePath,
    required this.propertiesCount,
  });
}

@immutable
class ServiceItem {
  final String label;
  final IconData icon;

  const ServiceItem({required this.label, required this.icon});
}

class HomeState {
  final bool isLoading;
  final String searchQuery;
  final PromoBanner? promoBanner;
  final List<CategoryItem> categories;
  final List<InfoCardItem> infoCards;
  final List<PropertyItem> recommendedProperties;
  final List<DeveloperItem> topDevelopers;
  final List<CompoundItem> topCompounds;
  final List<ServiceItem> services;

  const HomeState({
    this.isLoading = false,
    this.searchQuery = '',
    this.promoBanner,
    this.categories = const [],
    this.infoCards = const [],
    this.recommendedProperties = const [],
    this.topDevelopers = const [],
    this.topCompounds = const [],
    this.services = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? searchQuery,
    PromoBanner? promoBanner,
    List<CategoryItem>? categories,
    List<InfoCardItem>? infoCards,
    List<PropertyItem>? recommendedProperties,
    List<DeveloperItem>? topDevelopers,
    List<CompoundItem>? topCompounds,
    List<ServiceItem>? services,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      promoBanner: promoBanner ?? this.promoBanner,
      categories: categories ?? this.categories,
      infoCards: infoCards ?? this.infoCards,
      recommendedProperties: recommendedProperties ?? this.recommendedProperties,
      topDevelopers: topDevelopers ?? this.topDevelopers,
      topCompounds: topCompounds ?? this.topCompounds,
      services: services ?? this.services,
    );
  }
}