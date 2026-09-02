import 'package:flutter/material.dart';
import 'package:hansy/theme/constant.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    (icon: Icons.explore_outlined, activeIcon: Icons.explore, label: 'Explore'),
    (icon: Icons.bookmark_border, activeIcon: Icons.bookmark, label: 'Favorite'),
    (icon: Icons.more_horiz, activeIcon: Icons.more_horiz, label: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = index == currentIndex;
              final color = isActive ? AppColors.submitRed : AppColors.textGrey;

              return GestureDetector(
                onTap: () => onTap(index),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isActive ? item.activeIcon : item.icon, color: color, size: 22),
                    const SizedBox(height: 2),
                    Text(item.label, style: TextStyle(fontSize: 11, color: color)),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}