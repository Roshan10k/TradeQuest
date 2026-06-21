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
          indicatorColor: AppColors.primary.withValues(alpha: 0.2),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, size: 22),
              selectedIcon: Icon(
                Icons.home_rounded,
                size: 22,
                color: AppColors.primary,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.candlestick_chart_outlined, size: 22),
              selectedIcon: Icon(
                Icons.candlestick_chart,
                size: 22,
                color: AppColors.primary,
              ),
              label: 'Markets',
            ),
            NavigationDestination(
              icon: Icon(Icons.swap_horiz_rounded, size: 22),
              selectedIcon: Icon(
                Icons.swap_horiz,
                size: 22,
                color: AppColors.primary,
              ),
              label: 'Trade',
            ),
            NavigationDestination(
              icon: Icon(Icons.article_outlined, size: 22),
              selectedIcon: Icon(
                Icons.article,
                size: 22,
                color: AppColors.primary,
              ),
              label: 'News',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, size: 22),
              selectedIcon: Icon(
                Icons.person,
                size: 22,
                color: AppColors.primary,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
