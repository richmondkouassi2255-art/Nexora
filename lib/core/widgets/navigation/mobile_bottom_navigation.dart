import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';

class MobileBottomNavigation extends StatelessWidget {
  const MobileBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const List<NavigationDestination> _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Accueil',
    ),
    NavigationDestination(
      icon: Icon(Icons.people_outline_rounded),
      selectedIcon: Icon(Icons.people_rounded),
      label: 'Amis',
    ),
    NavigationDestination(
      icon: Icon(Icons.play_circle_outline_rounded),
      selectedIcon: Icon(Icons.play_circle_fill_rounded),
      label: 'Vidéo',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_bubble_outline_rounded),
      selectedIcon: Icon(Icons.chat_bubble_rounded),
      label: 'Messages',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight,
        elevation: 0,
        destinations: _destinations,
      ),
    );
  }
}
