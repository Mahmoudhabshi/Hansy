import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState()) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));

    
    await Future.delayed(const Duration(milliseconds: 600));

    emit(state.copyWith(
      isLoading: false,
      promoBanner: const PromoBanner(
        title: 'Join The Hansy Circle .',
        subtitle: "Whether you're an expert in the field or have a strong network .",
        buttonLabel: 'Contact us',
      ),
      categories: const [
        CategoryItem(label: 'Villas', imagePath: 'assets/images/villa.png'),
        CategoryItem(label: 'Apartment', imagePath: 'assets/images/apartment.png'),
        CategoryItem(label: 'Duplex', imagePath: 'assets/images/duplex.png'),
        CategoryItem(label: 'Chalets', imagePath: 'assets/images/chalets.png'),
        CategoryItem(label: 'Serviced Apt.', imagePath: 'assets/images/serviced_apart.png'),
      ],
      infoCards: const [
        InfoCardItem(
          title: 'Find Homes Near You',
          subtitle: 'Discover available properties based on your location',
          icon: Icons.home_outlined,
        ),
        InfoCardItem(
          title: 'Special Investment',
          subtitle: 'Unlock exclusive limited-time discounts',
          icon: Icons.trending_up,
        ),
      ],
      recommendedProperties: const [
        PropertyItem(
          id: 'p1',
          imagePath: 'assets/images/frame.png',
          price: '5,000,000 L.E',
          title: 'Lorem ipsum dolor sit',
          location: 'Alexandria , Egypt',
          type: 'Villa',
          beds: 4,
          baths: 3,
          area: '400 Sq.ft',
          agentPhone: '+201000000000',
          agentWhatsapp: '+201000000000',
        ),
        PropertyItem(
          id: 'p2',
          imagePath: 'assets/images/frame.png',
          price: '3,200,000 L.E',
          title: 'Lorem ipsum dolor sit',
          location: 'Cairo , Egypt',
          type: 'Apartment',
          beds: 2,
          baths: 2,
          area: '180 Sq.ft',
          agentPhone: '+201000000001',
          agentWhatsapp: '+201000000001',
        ),
      ],
      topDevelopers: const [
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/top1.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/elsewhere.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/mountain_view.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/palm_hills.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/orascom.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/top1.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/elsewhere.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/mountain_view.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/palm_hills.png'),
        DeveloperItem(name: '', logoPath: 'assets/images/Top_developers/orascom.png'),
      ],
      topCompounds: const [
        CompoundItem(name: 'Palm Hills', imagePath: 'assets/images/top_compounds/palmhillsTC.png', propertiesCount: 515),
        CompoundItem(name: 'Mountain View', imagePath: 'assets/images/top_compounds/mountainviewTC.png', propertiesCount: 515),
        CompoundItem(name: 'Palm Hills', imagePath: 'assets/images/top_compounds/palmhillsTC.png', propertiesCount: 515),
        CompoundItem(name: 'Mountain View', imagePath: 'assets/images/top_compounds/mountainviewTC.png', propertiesCount: 515),
      ],
      services: const [
        ServiceItem(label: 'Buy a property', icon: Icons.house_outlined),
        ServiceItem(label: 'Rent a property', icon: Icons.vpn_key_outlined),
        ServiceItem(label: 'Sell property', icon: Icons.sell_outlined),
      ],
    ));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void toggleFavorite(String propertyId) {
    final updated = state.recommendedProperties.map((property) {
      if (property.id == propertyId) {
        return property.copyWith(isFavorite: !property.isFavorite);
      }
      return property;
    }).toList();

    emit(state.copyWith(recommendedProperties: updated));
  }

  Future<void> verifyAgentPhone(String phone) async {
  }
}