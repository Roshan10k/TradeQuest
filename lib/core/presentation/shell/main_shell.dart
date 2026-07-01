import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/theme/app_colors.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.navBar,
          border: Border(
            top: BorderSide(color: AppColors.cardBorder, width: 0.5),
          ),
        ),
        child: NavigationBar(
          height: 64,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                size: 22,
                color: AppColors.accentGreen,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.swap_horiz_rounded,
                size: 22,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.swap_horiz_rounded,
                size: 22,
                color: AppColors.accentGreen,
              ),
              label: 'Trade',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.emoji_events_outlined,
                size: 22,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.emoji_events_rounded,
                size: 22,
                color: AppColors.accentGreen,
              ),
              label: 'Missions',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.pie_chart_outline_rounded,
                size: 22,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.pie_chart_rounded,
                size: 22,
                color: AppColors.accentGreen,
              ),
              label: 'Portfolio',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                size: 22,
                color: AppColors.textSecondary,
              ),
              selectedIcon: Icon(
                Icons.person_rounded,
                size: 22,
                color: AppColors.accentGreen,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
