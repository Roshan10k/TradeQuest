import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Center(
              child: Container(
                height: 92,
                width: 92,
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x663D4DF2),
                      blurRadius: 34,
                      spreadRadius: -6,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 86,
                  height: 86,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Learn to trade.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 29, height: 1.05),
            ),
            Text(
              'Risk-free.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 29,
                height: 1.05,
                color: AppColors.button,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                'Master the markets with institutional-grade tools and zero financial risk.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 22),
            FlowPanel(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VIRTUAL CAPITAL',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$100,000.00',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 28,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: const [
                      Icon(
                        Icons.trending_up_rounded,
                        size: 14,
                        color: AppColors.accentGreen,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Demo Credit Active',
                        style: TextStyle(
                          color: AppColors.accentGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 4,
                      value: 0.53,
                      backgroundColor: AppColors.bgCardAlt,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.button,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TRADING POWER',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'LVL 12 READY',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _FeatureChip(
                  icon: Icons.check_box_outline_blank_rounded,
                  label: 'COMPLETE\nQUESTS',
                ),
                _FeatureChip(
                  icon: Icons.bar_chart_rounded,
                  label: 'TRACK\nPROFITS',
                ),
                _FeatureChip(
                  icon: Icons.emoji_events_outlined,
                  label: 'TOP\nLEAGUE',
                ),
              ],
            ),
            const SizedBox(height: 24),
            FlowPrimaryButton(
              label: 'Get started',
              icon: Icons.arrow_forward,
              onPressed: () => context.push(AppRoutes.signUp),
            ),
            const SizedBox(height: 14),
            FlowSecondaryButton(
              label: 'I already have an account',
              onPressed: () => context.push(AppRoutes.login),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: AppColors.bgCard.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderDefault),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 26),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.1,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}
