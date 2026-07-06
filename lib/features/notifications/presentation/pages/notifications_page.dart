import 'package:flutter/material.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';

class _Notif {
  _Notif({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    this.unread = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  bool unread;
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<_Notif> _items = [
    _Notif(
      icon: Icons.lock_open_rounded,
      color: AppColors.accentGreen,
      title: 'Mission unlocked',
      body: '"Hold a position 24h" is now available to start.',
      time: '2m ago',
      unread: true,
    ),
    _Notif(
      icon: Icons.trending_up_rounded,
      color: AppColors.accentGreen,
      title: 'Price alert',
      body: 'AAPL is up 4.2% today — check your watchlist.',
      time: '1h ago',
      unread: true,
    ),
    _Notif(
      icon: Icons.workspace_premium_rounded,
      color: AppColors.accentAmber,
      title: 'Badge earned',
      body: "You earned the 'Diversified' badge. Nice work!",
      time: '3h ago',
    ),
    _Notif(
      icon: Icons.bolt_rounded,
      color: AppColors.accentAmber,
      title: 'Double XP Weekend',
      body: '2x rewards are active on market missions for 48 hours.',
      time: '1d ago',
    ),
    _Notif(
      icon: Icons.leaderboard_rounded,
      color: AppColors.button,
      title: 'Leaderboard update',
      body: 'You moved up to rank #142. Keep climbing!',
      time: '2d ago',
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final n in _items) {
        n.unread = false;
      }
    });
    showAppToast(context, 'All notifications marked as read');
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = _items.any((n) => n.unread);
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (hasUnread)
                    TextButton(
                      onPressed: _markAllRead,
                      child: Text(
                        'Mark all',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.button,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                itemCount: _items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) => _NotifTile(
                  notif: _items[i],
                  onTap: () => setState(() => _items[i].unread = false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({required this.notif, required this.onTap});

  final _Notif notif;
  final VoidCallback onTap;

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
            color: notif.unread ? AppColors.bgCardAlt : AppColors.bgCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: notif.unread
                  ? AppColors.button.withValues(alpha: 0.3)
                  : AppColors.borderDefault,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: notif.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(notif.icon, color: notif.color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        if (notif.unread)
                          Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.button,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif.body,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notif.time,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
