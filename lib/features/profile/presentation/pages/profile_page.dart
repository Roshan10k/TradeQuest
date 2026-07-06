import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';

class _Badge {
  const _Badge(this.icon, this.label, this.color, {this.locked = false});
  final IconData icon;
  final String label;
  final Color color;
  final bool locked;
}

const _badges = <_Badge>[
  _Badge(Icons.emoji_emotions_rounded, 'Rookie', AppColors.accentGreen),
  _Badge(Icons.pie_chart_rounded, 'Diversified', AppColors.button),
  _Badge(Icons.memory_rounded, 'Tech Buyer', AppColors.accentAmber),
  _Badge(Icons.trending_up_rounded, 'Bullish', AppColors.accentGreen),
];

const _allBadges = <_Badge>[
  _Badge(Icons.emoji_emotions_rounded, 'Rookie', AppColors.accentGreen),
  _Badge(Icons.pie_chart_rounded, 'Diversified', AppColors.button),
  _Badge(Icons.memory_rounded, 'Tech Buyer', AppColors.accentAmber),
  _Badge(Icons.trending_up_rounded, 'Bullish', AppColors.accentGreen),
  _Badge(
    Icons.nightlight_round,
    'Night Owl',
    AppColors.textTertiary,
    locked: true,
  ),
  _Badge(
    Icons.local_fire_department_rounded,
    '30-Day Streak',
    AppColors.textTertiary,
    locked: true,
  ),
  _Badge(
    Icons.workspace_premium_rounded,
    'Top 100',
    AppColors.textTertiary,
    locked: true,
  ),
  _Badge(
    Icons.shield_rounded,
    'Risk Manager',
    AppColors.textTertiary,
    locked: true,
  ),
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showAppModalSheet<bool>(
      context,
      title: 'Log out?',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'You will need to sign in again to access your portfolio.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentRed,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.borderDefault),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.go(AppRoutes.welcome);
    }
  }

  Future<void> _showAllBadges(BuildContext context) {
    return showAppModalSheet<void>(
      context,
      title: 'All Badges',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 12,
            children: _allBadges.map((b) => _BadgeChip(badge: b)).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentGreen,
                          width: 2.5,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.bgCardAlt,
                        child: Icon(
                          Icons.person_rounded,
                          size: 48,
                          color: AppColors.accentGreen,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.bgPrimary,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'LVL 14',
                          style: TextStyle(
                            color: Color(0xFF06351F),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Alex Rivers',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Elite Portfolio Strategist',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Text(
                    'XP Progress',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '1,250 / 2,000',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: const LinearProgressIndicator(
                  minHeight: 8,
                  value: 0.625,
                  backgroundColor: AppColors.bgCardAlt,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.button),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: _MiniStat(
                      icon: Icons.local_fire_department_rounded,
                      iconColor: AppColors.accentGreen,
                      label: 'Day Streak',
                      value: '12 Days',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _MiniStat(
                      icon: Icons.workspace_premium_rounded,
                      iconColor: AppColors.accentAmber,
                      label: 'Badges',
                      value: '04 Earned',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    'Earned Badges',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showAllBadges(context),
                    child: Text(
                      'View All',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.button,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _badges.map((b) => _BadgeChip(badge: b)).toList(),
              ),
              const SizedBox(height: 26),
              Text(
                'Account Actions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 14),
              _ActionRow(
                icon: Icons.settings_rounded,
                iconColor: AppColors.button,
                title: 'Settings',
                subtitle: 'Preferences and security',
                onTap: () => context.push(AppRoutes.settings),
              ),
              const SizedBox(height: 12),
              _ActionRow(
                icon: Icons.help_outline_rounded,
                iconColor: AppColors.accentAmber,
                title: 'Help Centre',
                subtitle: 'Support and documentation',
                onTap: () => context.push(AppRoutes.help),
              ),
              const SizedBox(height: 12),
              _ActionRow(
                icon: Icons.logout_rounded,
                iconColor: AppColors.accentRed,
                title: 'Log Out',
                subtitle: 'End your current session',
                titleColor: AppColors.accentRed,
                showChevron: false,
                onTap: () => _confirmLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final _Badge badge;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: badge.color.withValues(alpha: 0.12),
                border: Border.all(color: badge.color, width: 2),
              ),
              child: Icon(badge.icon, color: badge.color, size: 28),
            ),
            if (badge.locked)
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black38,
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          badge.label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor = AppColors.textPrimary,
    this.showChevron = true,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color titleColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderDefault),
          ),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
