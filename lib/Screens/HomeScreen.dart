import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/logic/cubit/home/home_cubit.dart';
import 'package:hansy/logic/cubit/home/home_state.dart';
import 'package:hansy/Screens/appbottomnavbar.dart';
import 'package:hansy/Screens/filterscreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final TextEditingController _searchController = TextEditingController();
  int _currentNavIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const FilterScreen()),
    );
  }

  void _onViewAllCategories() {}
  void _onContactUs() {}
  void _onCallTap(String? phone) {}
  void _onWhatsappTap(String? phone) {}
  void _onViewPropertyDetails() {}
  void _onSeeAllProperties() {}
  void _onExploreCompound(CompoundItem compound) {}
  void _onViewAllCompounds() {}
  void _onServiceTap(ServiceItem service) {}
  void _onApplyToBeMember() {}
  void _onNavTap(int index) => setState(() => _currentNavIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = context.read<HomeCubit>();

          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeHeader(
                    controller: _searchController,
                    onFilterTap: _onFilterTap,
                    onSearchChanged: cubit.updateSearchQuery,
                  ),

                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          if (state.promoBanner != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: _PromoCard(
                                promo: state.promoBanner!,
                                onButtonTap: _onContactUs,
                              ),
                            ),

                          const SizedBox(height: 24),

                          _SectionHeader(title: 'All Category', onViewAll: _onViewAllCategories),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.categories.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return _CategoryThumbnail(category: state.categories[index]);
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.infoCards.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return _InfoCard(info: state.infoCards[index]);
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Recommended Property',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (state.recommendedProperties.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: _PropertyCard(
                                property: state.recommendedProperties.first,
                                onFavoriteTap: () => cubit.toggleFavorite(state.recommendedProperties.first.id),
                                onCallTap: () => _onCallTap(state.recommendedProperties.first.agentPhone),
                                onWhatsappTap: () => _onWhatsappTap(state.recommendedProperties.first.agentWhatsapp),
                                onViewDetailsTap: _onViewPropertyDetails,
                              ),
                            ),
                          const SizedBox(height: 12),
                          Center(
                            child: GestureDetector(
                              onTap: _onSeeAllProperties,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('See All Properties', style: TextStyle(fontSize: 13, color: AppColors.black, fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 2),
                                  const Icon(Icons.expand_more, size: 16, color: AppColors.black),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Top Developers',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 50,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.topDevelopers.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 24),
                              itemBuilder: (context, index) {
                                return _DeveloperLogo(developer: state.topDevelopers[index]);
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Top Compounds',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 150,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: state.topCompounds.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 14),
                              itemBuilder: (context, index) {
                                return _CompoundCard(
                                  compound: state.topCompounds[index],
                                  onExploreTap: () => _onExploreCompound(state.topCompounds[index]),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: GestureDetector(
                              onTap: _onViewAllCompounds,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('View All', style: TextStyle(fontSize: 13, color: AppColors.black, fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 2),
                                  const Icon(Icons.expand_more, size: 16, color: AppColors.black),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _AgentVerificationCard(onVerify: cubit.verifyAgentPhone),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Our Services',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                for (int i = 0; i < state.services.length; i++) ...[
                                  Expanded(
                                    child: _ServiceGridItem(
                                      service: state.services[i],
                                      onTap: () => _onServiceTap(state.services[i]),
                                    ),
                                  ),
                                  if (i != state.services.length - 1) const SizedBox(width: 12),
                                ],
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _JoinNetworkCard(
                              onApplyTap: _onApplyToBeMember,
                              onWhatsappTap: () => _onWhatsappTap(null),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

/// Maroon photo-background header with logo, title, search bar.
class _HomeHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onSearchChanged;

  const _HomeHeader({
    required this.controller,
    required this.onFilterTap,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        image: DecorationImage(
          image: const AssetImage('assets/images/home/header_bg.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.background.withOpacity(0.55),
            BlendMode.darken,
          ),
          onError: (_, __) {}, // falls back to the solid background color if missing
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/hansy_logo.png',
            height: 20,
            color: AppColors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            'Discover\nYour Future Home',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Explore listings tailored to your dreams.',
            style: TextStyle(fontSize: 13, color: AppColors.white.withOpacity(0.85)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller,
                    onChanged: onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: AppColors.placeholderGrey, fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: AppColors.placeholderGrey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: AppColors.submitRed),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The red "Join The Hansy Circle ." promo card.
class _PromoCard extends StatelessWidget {
  final PromoBanner promo;
  final VoidCallback onButtonTap;

  const _PromoCard({required this.promo, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFE23744), // brighter red
            AppColors.background, // dark maroon
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 14, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            promo.title,
            style: const TextStyle(color: AppColors.white, fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            promo.subtitle,
            style: TextStyle(color: AppColors.white.withOpacity(0.9), fontSize: 13),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onButtonTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.submitRed,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Text(
                promo.buttonLabel,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.black)),
          GestureDetector(
            onTap: onViewAll,
            child: Row(
              children: [
                Text('View All', style: TextStyle(fontSize: 13, color: AppColors.black, fontWeight: FontWeight.w600)),
                const SizedBox(width: 2),
                const Icon(Icons.expand_more, size: 16, color: AppColors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Rectangular photo thumbnail for a category, with label below.
class _CategoryThumbnail extends StatelessWidget {
  final CategoryItem category;

  const _CategoryThumbnail({required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              category.imagePath,
              width: 72,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 64,
                decoration: BoxDecoration(color: AppColors.iconCircleBg, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.home_work_outlined, color: AppColors.submitRed),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            category.label,
            style: const TextStyle(fontSize: 11, color: AppColors.textDark),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// "Find Homes Near You" / "Special Investment" style info card.
class _InfoCard extends StatelessWidget {
  final InfoCardItem info;

  const _InfoCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.iconCircleBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.black)),
                const SizedBox(height: 4),
                Text(
                  info.subtitle,
                  style: TextStyle(fontSize: 11, color: AppColors.textGrey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(color: AppColors.submitRed, shape: BoxShape.circle),
            child: Icon(info.icon, color: AppColors.white, size: 18),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final PropertyItem property;
  final VoidCallback onFavoriteTap;
  final VoidCallback onCallTap;
  final VoidCallback onWhatsappTap;
  final VoidCallback onViewDetailsTap;

  const _PropertyCard({
    required this.property,
    required this.onFavoriteTap,
    required this.onCallTap,
    required this.onWhatsappTap,
    required this.onViewDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  property.imagePath,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: AppColors.iconCircleBg,
                    child: const Icon(Icons.map_outlined, color: AppColors.submitRed, size: 32),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Row(
                  children: [
                    _RoundIconButton(icon: Icons.call, color: AppColors.submitRed, onTap: onCallTap),
                    const SizedBox(width: 6),
                    _RoundIconButton(icon: Icons.chat, color: const Color(0xFF25D366), onTap: onWhatsappTap),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
                    child: Icon(
                      property.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: AppColors.submitRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.price, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.submitRed)),
                const SizedBox(height: 4),
                Text(property.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _PropertySpec(icon: Icons.square_foot, label: property.area),
                    const SizedBox(width: 20),
                    _PropertySpec(icon: Icons.bed_outlined, label: '${property.beds} Rooms'),
                    const SizedBox(width: 20),
                    _PropertySpec(icon: Icons.bathtub_outlined, label: '${property.baths} Baths'),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onViewDetailsTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.submitRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('View Property Details', style: AppTextStyles.buttonLabel),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertySpec extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PropertySpec({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: AppColors.textGrey),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.textGrey)),
      ],
    );
  }
}

class _DeveloperLogo extends StatelessWidget {
  final DeveloperItem developer;

  const _DeveloperLogo({required this.developer});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      developer.logoPath,
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Text(
        developer.name,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark),
      ),
    );
  }
}

class _CompoundCard extends StatelessWidget {
  final CompoundItem compound;
  final VoidCallback onExploreTap;

  const _CompoundCard({required this.compound, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            compound.imagePath,
            width: 165,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 165,
              height: 150,
              color: AppColors.iconCircleBg,
              child: const Icon(Icons.location_city, color: AppColors.submitRed),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(compound.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                Text('${compound.propertiesCount} Properties', style: TextStyle(color: AppColors.white.withOpacity(0.85), fontSize: 11)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onExploreTap,
                  child: Text(
                    'Explore Now',
                    style: TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "Protect yourself by verifying if your agent is officially certified"
/// card — takes a phone number and calls [onVerify].
class _AgentVerificationCard extends StatefulWidget {
  final ValueChanged<String> onVerify;

  const _AgentVerificationCard({required this.onVerify});

  @override
  State<_AgentVerificationCard> createState() => _AgentVerificationCardState();
}

class _AgentVerificationCardState extends State<_AgentVerificationCard> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onCancel() {
    _phoneController.clear();
    FocusScope.of(context).unfocus();
  }

  void _onVerifyTap() {
    widget.onVerify(_phoneController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.iconCircleBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: AppColors.submitRed, shape: BoxShape.circle),
            child: const Icon(Icons.verified_user_outlined, color: AppColors.white, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            'Protect yourself by verifying if your agent is officially certified with Hansy Real Estate',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.black),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Agent Phone Number',
                hintStyle: TextStyle(color: AppColors.placeholderGrey, fontSize: 13),
                prefixIcon: const Icon(Icons.call_outlined, color: AppColors.placeholderGrey, size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _onCancel,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.inputBorder),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Cancel', style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _onVerifyTap,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(color: AppColors.submitRed, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: AppColors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceGridItem extends StatelessWidget {
  final ServiceItem service;
  final VoidCallback onTap;

  const _ServiceGridItem({required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          children: [
            Icon(service.icon, color: AppColors.submitRed, size: 26),
            const SizedBox(height: 8),
            Text(
              service.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class _JoinNetworkCard extends StatelessWidget {
  final VoidCallback onApplyTap;
  final VoidCallback onWhatsappTap;

  const _JoinNetworkCard({required this.onApplyTap, required this.onWhatsappTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: const AssetImage('assets/images/home/network_bg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(AppColors.background.withOpacity(0.75), BlendMode.darken),
              onError: (_, __) {},
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Join Our Real Estate Network',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Become a certified member and unlock exclusive tools, listings, and growth opportunities in the real estate industry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white.withOpacity(0.85), fontSize: 12),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: onApplyTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.submitRed,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Apply to be Hansy Member', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          bottom: -18,
          child: GestureDetector(
            onTap: onWhatsappTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(color: Color(0xFF25D366), shape: BoxShape.circle),
              child: const Icon(Icons.chat, color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
        child: Icon(icon, size: 14, color: color),
      ),
    );
  }
}