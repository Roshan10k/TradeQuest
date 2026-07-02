import 'package:flutter/material.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';

class _Asset {
  const _Asset({
    required this.symbol,
    required this.name,
    required this.shares,
    required this.price,
    required this.change,
    required this.isUp,
  });

  final String symbol;
  final String name;
  final String shares;
  final String price;
  final String change;
  final bool isUp;
}

class _Sector {
  const _Sector({
    required this.name,
    required this.color,
    required this.value,
    required this.valueLabel,
    required this.changeLabel,
    required this.isUp,
    required this.assets,
  });

  final String name;
  final Color color;
  final double value;
  final String valueLabel;
  final String changeLabel;
  final bool isUp;
  final List<_Asset> assets;
}

const _sectors = <_Sector>[
  _Sector(
    name: 'Technology',
    color: AppColors.button,
    value: 56066.48,
    valueLabel: '\$56,066.48',
    changeLabel: '+2.4% Today',
    isUp: true,
    assets: [
      _Asset(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        shares: '120 Shares',
        price: '\$192.53',
        change: '+\$1.22 (0.6%)',
        isUp: true,
      ),
      _Asset(
        symbol: 'MSFT',
        name: 'Microsoft Corp.',
        shares: '85 Shares',
        price: '\$415.10',
        change: '+\$4.12 (1.0%)',
        isUp: true,
      ),
      _Asset(
        symbol: 'NVDA',
        name: 'NVIDIA Corp.',
        shares: '42 Shares',
        price: '\$875.28',
        change: '+\$12.45 (1.4%)',
        isUp: true,
      ),
    ],
  ),
  _Sector(
    name: 'Energy',
    color: AppColors.accentAmber,
    value: 31148.04,
    valueLabel: '\$31,148.04',
    changeLabel: '-0.8% Today',
    isUp: false,
    assets: [
      _Asset(
        symbol: 'XOM',
        name: 'Exxon Mobil',
        shares: '210 Shares',
        price: '\$118.24',
        change: '-\$0.45 (0.3%)',
        isUp: false,
      ),
      _Asset(
        symbol: 'CVX',
        name: 'Chevron Corp.',
        shares: '105 Shares',
        price: '\$158.40',
        change: '-\$1.20 (0.7%)',
        isUp: false,
      ),
    ],
  ),
  _Sector(
    name: 'Healthcare',
    color: AppColors.accentGreen,
    value: 18688.82,
    valueLabel: '\$18,688.82',
    changeLabel: '+1.1% Today',
    isUp: true,
    assets: [
      _Asset(
        symbol: 'JNJ',
        name: 'Johnson & Johnson',
        shares: '52 Shares',
        price: '\$154.62',
        change: '+\$1.68 (1.1%)',
        isUp: true,
      ),
    ],
  ),
];

enum _SortMode { valueDesc, valueAsc, nameAsc }

extension on _SortMode {
  String get label => switch (this) {
    _SortMode.valueDesc => 'Value',
    _SortMode.valueAsc => 'Value (Low→High)',
    _SortMode.nameAsc => 'Name',
  };
}

class PortfolioBreakdownPage extends StatefulWidget {
  const PortfolioBreakdownPage({super.key});

  @override
  State<PortfolioBreakdownPage> createState() => _PortfolioBreakdownPageState();
}

class _PortfolioBreakdownPageState extends State<PortfolioBreakdownPage> {
  _SortMode _sort = _SortMode.valueDesc;
  late Set<String> _visible = _sectors.map((s) => s.name).toSet();

  List<_Sector> get _shown {
    final list = _sectors.where((s) => _visible.contains(s.name)).toList();
    switch (_sort) {
      case _SortMode.valueDesc:
        list.sort((a, b) => b.value.compareTo(a.value));
      case _SortMode.valueAsc:
        list.sort((a, b) => a.value.compareTo(b.value));
      case _SortMode.nameAsc:
        list.sort((a, b) => a.name.compareTo(b.name));
    }
    return list;
  }

  String get _filterLabel => _visible.length == _sectors.length
      ? 'All Sectors'
      : '${_visible.length} Sector${_visible.length == 1 ? '' : 's'}';

  Future<void> _openSort() async {
    final picked = await showAppModalSheet<_SortMode>(
      context,
      title: 'Sort by',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _SortMode.values.map((mode) {
          final selected = mode == _sort;
          return ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => Navigator.of(context).pop(mode),
            title: Text(
              mode.label,
              style: TextStyle(
                color: selected ? AppColors.button : AppColors.textPrimary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            trailing: selected
                ? const Icon(Icons.check_rounded, color: AppColors.button)
                : null,
          );
        }).toList(),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _sort = picked);
      showAppToast(
        context,
        'Sorted by ${picked.label}',
        icon: Icons.sort_rounded,
        accent: AppColors.button,
      );
    }
  }

  Future<void> _openFilter() async {
    final working = {..._visible};
    final applied = await showAppModalSheet<Set<String>>(
      context,
      title: 'Filter Sectors',
      child: StatefulBuilder(
        builder: (context, setSheet) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ..._sectors.map((s) {
                final on = working.contains(s.name);
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: on,
                  activeColor: AppColors.button,
                  checkColor: AppColors.buttonText,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    s.name,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  onChanged: (v) => setSheet(() {
                    if (v == true) {
                      working.add(s.name);
                    } else if (working.length > 1) {
                      working.remove(s.name);
                    }
                  }),
                );
              }),
              const SizedBox(height: 12),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: Color(0x4D6366F1), blurRadius: 15),
                  ],
                ),
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(working),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          );
        },
      ),
    );
    if (applied != null && mounted) {
      setState(() => _visible = applied);
      showAppToast(
        context,
        'Showing $_filterLabel',
        icon: Icons.filter_list_rounded,
        accent: AppColors.button,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    'Portfolio Breakdown',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Row(
                  children: [
                    Text(
                      'Total Portfolio: ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '\$124,592.18',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _AllocationPanel(),
              const SizedBox(height: 16),
              Row(
                children: [
                  _ControlButton(
                    icon: Icons.sort_rounded,
                    label: 'Sort by: ${_sort.label}',
                    filled: true,
                    onTap: _openSort,
                  ),
                  const SizedBox(width: 12),
                  _ControlButton(
                    icon: Icons.filter_list_rounded,
                    label: 'Filter: $_filterLabel',
                    filled: false,
                    onTap: _openFilter,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ..._shown.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _SectorCard(sector: s),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllocationPanel extends StatelessWidget {
  static const _segments = <(String, int, Color)>[
    ('TECH', 45, AppColors.button),
    ('ENERGY', 25, AppColors.accentGreen),
    ('HEALTH', 15, AppColors.accentAmber),
    ('FIN', 10, Color(0xFF2DD4BF)),
    ('', 5, AppColors.bgCardAlt),
  ];

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECTOR ALLOCATION',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '8 Sectors',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.button,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Row(
              children: _segments
                  .map(
                    (seg) => Expanded(
                      flex: seg.$2,
                      child: Container(
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        color: seg.$3,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: _segments
                .where((seg) => seg.$1.isNotEmpty)
                .map(
                  (seg) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: seg.$3,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${seg.$1} ${seg.$2}%',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.label,
    required this.filled,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = filled ? AppColors.buttonText : AppColors.textSecondary;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: filled ? AppColors.button : AppColors.bgCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: filled ? Colors.transparent : AppColors.borderDefault,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectorCard extends StatelessWidget {
  const _SectorCard({required this.sector});

  final _Sector sector;

  @override
  Widget build(BuildContext context) {
    final changeColor = sector.isUp
        ? AppColors.accentGreen
        : AppColors.accentRed;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sector.name,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: sector.color,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${sector.assets.length} Asset'
                      '${sector.assets.length == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    sector.valueLabel,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    sector.changeLabel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: changeColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...sector.assets.map((a) => _AssetRow(asset: a)),
        ],
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({required this.asset});

  final _Asset asset;

  @override
  Widget build(BuildContext context) {
    final changeColor = asset.isUp
        ? AppColors.accentGreen
        : AppColors.accentRed;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgCardAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bgPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              asset.symbol,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  asset.shares,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                asset.price,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                asset.change,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: changeColor,
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
