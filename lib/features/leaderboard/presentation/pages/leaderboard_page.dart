import 'package:flutter/material.dart';
import 'package:tradequest/core/theme/app_colors.dart';

class _Entry {
  const _Entry({
    required this.rank,
    required this.name,
    required this.subtitle,
    required this.xp,
    this.color = AppColors.button,
  });

  final int rank;
  final String name;
  final String subtitle;
  final String xp;
  final Color color;
}

class _Board {
  const _Board({required this.podium, required this.rest, required this.you});

  final List<_Entry> podium; // [#1, #2, #3]
  final List<_Entry> rest;
  final _Entry you;
}

const _globalBoard = _Board(
  podium: [
    _Entry(
      rank: 1,
      name: 'TradeGod',
      subtitle: '',
      xp: '15.8K XP',
      color: AppColors.accentAmber,
    ),
    _Entry(
      rank: 2,
      name: 'Alex.sol',
      subtitle: '',
      xp: '12.4K XP',
      color: Color(0xFF60A5FA),
    ),
    _Entry(
      rank: 3,
      name: 'CryptoCat',
      subtitle: '',
      xp: '10.1K XP',
      color: AppColors.accentGreen,
    ),
  ],
  rest: [
    _Entry(
      rank: 4,
      name: 'Max_Margin',
      subtitle: 'Top 1% This Week',
      xp: '9,842',
    ),
    _Entry(
      rank: 5,
      name: 'SarahSignals',
      subtitle: 'Consistent Gainer',
      xp: '9,210',
    ),
    _Entry(
      rank: 6,
      name: 'Kenji_Trades',
      subtitle: 'Market Explorer',
      xp: '8,955',
    ),
  ],
  you: _Entry(rank: 142, name: 'You (MasterTrader)', subtitle: '', xp: '1,250'),
);

const _friends = _Board(
  podium: [
    _Entry(
      rank: 1,
      name: 'Sam_R',
      subtitle: '',
      xp: '7.1K XP',
      color: AppColors.accentAmber,
    ),
    _Entry(
      rank: 2,
      name: 'Priya_V',
      subtitle: '',
      xp: '5.9K XP',
      color: Color(0xFF60A5FA),
    ),
    _Entry(
      rank: 3,
      name: 'You',
      subtitle: '',
      xp: '1.25K XP',
      color: AppColors.accentGreen,
    ),
  ],
  rest: [
    _Entry(rank: 4, name: 'Dev_M', subtitle: 'Just getting started', xp: '980'),
    _Entry(rank: 5, name: 'Lena', subtitle: 'New trader', xp: '540'),
  ],
  you: _Entry(rank: 3, name: 'You (MasterTrader)', subtitle: '', xp: '1,250'),
);

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool _isGlobal = true;

  @override
  Widget build(BuildContext context) {
    final board = _isGlobal ? _globalBoard : _friends;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
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
                    'Leaderboard',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _Segmented(
                global: _isGlobal,
                onChanged: (v) => setState(() => _isGlobal = v),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Column(
                  children: [
                    _Podium(podium: board.podium),
                    const SizedBox(height: 28),
                    ...board.rest.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _RankRow(entry: e),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: _YouCard(entry: board.you),
            ),
          ],
        ),
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({required this.global, required this.onChanged});

  final bool global;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Row(
        children: [
          _segment('GLOBAL', global, () => onChanged(true)),
          _segment('FRIENDS', !global, () => onChanged(false)),
        ],
      ),
    );
  }

  Widget _segment(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.button : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? AppColors.buttonText : AppColors.textSecondary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({required this.podium});

  final List<_Entry> podium;

  @override
  Widget build(BuildContext context) {
    final first = podium[0];
    final second = podium[1];
    final third = podium[2];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: _PodiumSpot(entry: second, height: 92)),
        const SizedBox(width: 10),
        Expanded(child: _PodiumSpot(entry: first, height: 132, isFirst: true)),
        const SizedBox(width: 10),
        Expanded(child: _PodiumSpot(entry: third, height: 78)),
      ],
    );
  }
}

class _PodiumSpot extends StatelessWidget {
  const _PodiumSpot({
    required this.entry,
    required this.height,
    this.isFirst = false,
  });

  final _Entry entry;
  final double height;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = isFirst ? 34.0 : 26.0;
    return Column(
      children: [
        if (isFirst)
          const Icon(Icons.star_rounded, color: AppColors.accentAmber, size: 22)
        else
          const SizedBox(height: 22),
        const SizedBox(height: 4),
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: entry.color, width: 2.5),
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: AppColors.bgCardAlt,
                child: Icon(
                  Icons.person_rounded,
                  color: entry.color,
                  size: avatarRadius,
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              child: Container(
                height: 22,
                width: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: entry.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bgPrimary, width: 2),
                ),
                child: Text(
                  '${entry.rank}',
                  style: const TextStyle(
                    color: Color(0xFF1A1400),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: BoxDecoration(
            color: isFirst
                ? AppColors.accentAmberDim.withValues(alpha: 0.55)
                : AppColors.bgCard,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            border: Border.all(
              color: isFirst
                  ? AppColors.accentAmber.withValues(alpha: 0.4)
                  : AppColors.borderDefault,
            ),
          ),
          child: Column(
            children: [
              Text(
                entry.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.xp,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isFirst
                      ? AppColors.accentAmber
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: isFirst ? 15 : 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RankRow extends StatelessWidget {
  const _RankRow({required this.entry});

  final _Entry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '${entry.rank}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.bgCardAlt,
            child: Icon(
              Icons.person_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (entry.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    entry.subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            entry.xp,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _YouCard extends StatelessWidget {
  const _YouCard({required this.entry});

  final _Entry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.button,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bgPrimary.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${entry.rank}',
              style: const TextStyle(
                color: AppColors.buttonText,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR CURRENT RANK',
                  style: TextStyle(
                    color: AppColors.buttonText.withValues(alpha: 0.7),
                    letterSpacing: 1.2,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.name,
                  style: const TextStyle(
                    color: AppColors.buttonText,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.xp,
                style: const TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'XP',
                style: TextStyle(
                  color: AppColors.buttonText.withValues(alpha: 0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
