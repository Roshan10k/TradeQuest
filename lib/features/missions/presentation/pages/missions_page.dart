import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';

enum MissionStatus { claimed, claimable, inProgress, locked }

class Mission {
  Mission({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.xp,
    required this.status,
    this.progress = 0,
    this.goal = 1,
    this.lockNote,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final int xp;
  MissionStatus status;
  final int progress;
  final int goal;
  final String? lockNote;
}

class MissionsPage extends StatefulWidget {
  const MissionsPage({super.key});

  @override
  State<MissionsPage> createState() => _MissionsPageState();
}

class _MissionsPageState extends State<MissionsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this)
    ..addListener(() => setState(() {}));

  final _daily = <Mission>[
    Mission(
      title: 'Buy a tech stock',
      subtitle: 'MISSION COMPLETE',
      icon: Icons.rocket_launch_rounded,
      accent: AppColors.accentGreen,
      xp: 100,
      status: MissionStatus.claimed,
    ),
    Mission(
      title: 'Diversify into 3 sectors',
      subtitle: 'Trade in Tech, Energy, and Retail',
      icon: Icons.pie_chart_rounded,
      accent: AppColors.button,
      xp: 250,
      status: MissionStatus.inProgress,
      progress: 1,
      goal: 3,
    ),
    Mission(
      title: 'Hold a position 24h',
      subtitle: '',
      icon: Icons.lock_rounded,
      accent: AppColors.textTertiary,
      xp: 150,
      status: MissionStatus.locked,
      lockNote: 'Unlocks after level 5',
    ),
  ];

  final _weekly = <Mission>[
    Mission(
      title: 'Complete 5 trades',
      subtitle: 'MISSION COMPLETE',
      icon: Icons.check_circle_rounded,
      accent: AppColors.accentGreen,
      xp: 500,
      status: MissionStatus.claimable,
    ),
    Mission(
      title: 'Reach \$130k portfolio',
      subtitle: 'Grow your virtual portfolio',
      icon: Icons.trending_up_rounded,
      accent: AppColors.button,
      xp: 400,
      status: MissionStatus.inProgress,
      progress: 4,
      goal: 5,
    ),
    Mission(
      title: '7-day login streak',
      subtitle: '',
      icon: Icons.lock_rounded,
      accent: AppColors.textTertiary,
      xp: 300,
      status: MissionStatus.locked,
      lockNote: 'Unlocks at level 8',
    ),
  ];

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _claim(Mission m) async {
    await _showCelebration(context, m.xp);
    if (!mounted) return;
    setState(() => m.status = MissionStatus.claimed);
    showAppToast(context, '+${m.xp} XP added to your balance');
  }

  @override
  Widget build(BuildContext context) {
    final missions = _tabs.index == 0 ? _daily : _weekly;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _RankCard(onTap: () => context.push(AppRoutes.leaderboard)),
              const SizedBox(height: 16),
              const _EventBanner(),
              const SizedBox(height: 8),
              _TabBar(controller: _tabs),
              const SizedBox(height: 16),
              ...missions.map(
                (m) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _MissionCard(
                    mission: m,
                    onClaim: () => _claim(m),
                    onGo: () => context.go(AppRoutes.trade),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankCard extends StatelessWidget {
  const _RankCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
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
                  color: AppColors.accentPurpleDim,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.leaderboard_rounded,
                  color: AppColors.button,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LEADERBOARD',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Rank #142 • MasterTrader',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'VIEW ALL',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.button,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.button,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventBanner extends StatelessWidget {
  const _EventBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF2B33D), Color(0xFFE08A1E)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.bolt_rounded,
                color: Color(0xFF3A2400),
                size: 18,
              ),
              const SizedBox(width: 4),
              Text(
                'EVENT ACTIVE',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF3A2400),
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Double XP Weekend',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF1F1400),
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Earn 2x rewards on all market missions for the next 48 hours.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4A3200),
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: AppColors.button,
      indicatorWeight: 2.5,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: AppColors.borderSubtle,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textSecondary,
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
      ),
      tabs: const [
        Tab(text: 'DAILY'),
        Tab(text: 'WEEKLY'),
      ],
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.mission,
    required this.onClaim,
    required this.onGo,
  });

  final Mission mission;
  final VoidCallback onClaim;
  final VoidCallback onGo;

  @override
  Widget build(BuildContext context) {
    final locked = mission.status == MissionStatus.locked;
    final done =
        mission.status == MissionStatus.claimed ||
        mission.status == MissionStatus.claimable;
    final borderColor = mission.status == MissionStatus.claimable
        ? AppColors.accentGreen.withValues(alpha: 0.5)
        : AppColors.borderDefault;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: locked
            ? AppColors.bgCardAlt.withValues(alpha: 0.5)
            : AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: mission.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(mission.icon, color: mission.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mission.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: locked
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _subtitle(context),
                  ],
                ),
              ),
              if (done)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.accentGreen,
                )
              else if (locked)
                const Icon(
                  Icons.hourglass_empty_rounded,
                  color: AppColors.textTertiary,
                ),
            ],
          ),
          if (mission.status == MissionStatus.inProgress) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  'PROGRESS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${mission.progress}/${mission.goal}',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: mission.progress / mission.goal,
                backgroundColor: AppColors.bgCardAlt,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.button,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          _footer(context),
        ],
      ),
    );
  }

  Widget _subtitle(BuildContext context) {
    if (mission.status == MissionStatus.claimed ||
        mission.status == MissionStatus.claimable) {
      return Text(
        mission.subtitle,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.accentGreen,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700,
        ),
      );
    }
    final text = mission.status == MissionStatus.locked
        ? (mission.lockNote ?? '')
        : mission.subtitle;
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
    );
  }

  Widget _footer(BuildContext context) {
    final xpText = Text(
      '+${mission.xp} XP',
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: mission.status == MissionStatus.locked
            ? AppColors.textTertiary
            : AppColors.accentGreen,
        fontWeight: FontWeight.w700,
      ),
    );

    switch (mission.status) {
      case MissionStatus.claimed:
        return Row(
          children: [
            xpText,
            const Spacer(),
            Text(
              'CLAIMED',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.accentGreen,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      case MissionStatus.claimable:
        return Row(
          children: [
            xpText,
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Color(0x4D6366F1), blurRadius: 15),
                ],
              ),
              child: FilledButton(
                onPressed: onClaim,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.button,
                  foregroundColor: AppColors.buttonText,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                child: const Text('Claim'),
              ),
            ),
          ],
        );
      case MissionStatus.inProgress:
        return Row(
          children: [
            xpText,
            const Spacer(),
            GestureDetector(
              onTap: onGo,
              child: Row(
                children: [
                  Text(
                    'GO TO MARKETS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.button,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.button,
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        );
      case MissionStatus.locked:
        return xpText;
    }
  }
}

Future<void> _showCelebration(BuildContext context, int xp) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.bgCard,
    barrierColor: Colors.black.withValues(alpha: 0.7),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
    ),
    builder: (context) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentAmber.withValues(alpha: 0.18),
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: AppColors.accentAmber,
                  size: 44,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Mission Accomplished!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You've earned a reward for completing this mission.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentGreenDim.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: AppColors.accentGreen.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  '+$xp XP earned',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: Color(0x4D6366F1), blurRadius: 15),
                  ],
                ),
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  child: const Text('Awesome!'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
