import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../responsive/responsive_extensions.dart';
import '../navigation/desktop_sidebar.dart';
import '../navigation/mobile_bottom_navigation.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.isDesktop;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            DesktopSidebar(
              currentIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            ),
            Expanded(
              child: navigationShell,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: MobileBottomNavigation(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
