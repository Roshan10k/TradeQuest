import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class BadgeUnlockPage extends StatelessWidget {
  const BadgeUnlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlowStepHeader(
              leading: 'STEP 3 OF 3',
              trailing: 'READY TO TRADE',
              progress: 1.0,
            ),
            const SizedBox(height: 26),
            Center(
              child: Container(
                height: 248,
                width: 248,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.button.withValues(alpha: 0.26),
                      Colors.transparent,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 168,
                  width: 168,
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x773D4DF2),
                        blurRadius: 28,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icon_rookie.svg',
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(child: _XpPill(label: '+320 XP')),
            const SizedBox(height: 18),
            Text(
              'Badge unlocked!',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 28, height: 1.08),
            ),
            Text(
              'Level 1 - Rookie',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 22,
                color: AppColors.button,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Text(
                  'GROWTH PATH',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textTertiary,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '320 / 1000 XP',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 12,
                value: 0.32,
                backgroundColor: AppColors.bgCardAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.button,
                ),
              ),
            ),
            const SizedBox(height: 22),
            FlowPanel(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'NEXT MISSION',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.rocket_launch_outlined,
                        color: AppColors.button,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Buy a stock from the hydro sector',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 21,
                      height: 1.18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Icon(
                        Icons.add_circle,
                        color: AppColors.accentGreen,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '+100 XP on Completion',
                        style: TextStyle(
                          color: AppColors.accentGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.borderSubtle),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Difficulty: Easy',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.textSecondary,
                        size: 22,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FlowPrimaryButton(
              label: 'Go to Dashboard',
              icon: Icons.grid_view_rounded,
              onPressed: () => context.go(AppRoutes.home),
            ),
            const SizedBox(height: 14),
            const Text(
              'Your journey has just begun, trader.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _XpPill extends StatelessWidget {
  const _XpPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.accentAmber,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.xpBadgeText,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
