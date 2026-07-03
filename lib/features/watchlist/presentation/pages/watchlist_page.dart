import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class _WatchItem {
  const _WatchItem({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isUp,
    required this.spark,
  });

  final String symbol;
  final String name;
  final String price;
  final String change;
  final bool isUp;
  final List<double> spark;
}

const _initial = <_WatchItem>[
  _WatchItem(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    price: '\$182.40',
    change: '+1.2%',
    isUp: true,
    spark: [1.0, 1.1, 0.95, 1.05, 1.2, 1.15, 1.3],
  ),
  _WatchItem(
    symbol: 'TSLA',
    name: 'Tesla Inc.',
    price: '\$193.57',
    change: '-0.5%',
    isUp: false,
    spark: [1.3, 1.25, 1.3, 1.1, 1.15, 1.0, 0.95],
  ),
  _WatchItem(
    symbol: 'MSFT',
    name: 'Microsoft',
    price: '\$415.10',
    change: '+2.4%',
    isUp: true,
    spark: [1.0, 1.05, 1.02, 1.12, 1.18, 1.22, 1.3],
  ),
  _WatchItem(
    symbol: 'NVDA',
    name: 'Nvidia Corp.',
    price: '\$726.13',
    change: '+4.1%',
    isUp: true,
    spark: [0.9, 1.0, 1.1, 1.15, 1.25, 1.4, 1.55],
  ),
];

const _suggestions = <_WatchItem>[
  _WatchItem(
    symbol: 'GOOGL',
    name: 'Alphabet Inc.',
    price: '\$172.30',
    change: '+0.8%',
    isUp: true,
    spark: [1.0, 1.05, 1.1, 1.08, 1.15],
  ),
  _WatchItem(
    symbol: 'AMZN',
    name: 'Amazon.com',
    price: '\$185.99',
    change: '+1.6%',
    isUp: true,
    spark: [1.0, 0.98, 1.05, 1.12, 1.2],
  ),
  _WatchItem(
    symbol: 'META',
    name: 'Meta Platforms',
    price: '\$496.12',
    change: '-0.3%',
    isUp: false,
    spark: [1.2, 1.18, 1.1, 1.12, 1.08],
  ),
];

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final List<_WatchItem> _items = [..._initial];

  void _remove(_WatchItem item) {
    setState(() => _items.remove(item));
    showAppToast(
      context,
      '${item.symbol} removed from watchlist',
      icon: Icons.delete_outline_rounded,
      accent: AppColors.accentRed,
    );
  }

  Future<void> _openAdd() async {
    final available = _suggestions
        .where((s) => !_items.any((i) => i.symbol == s.symbol))
        .toList();
    final picked = await showAppModalSheet<_WatchItem>(
      context,
      title: 'Add to Watchlist',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: available.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'No more suggestions right now.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ]
            : available
                  .map(
                    (s) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () => Navigator.of(context).pop(s),
                      leading: _SymbolBadge(symbol: s.symbol),
                      title: Text(
                        s.symbol,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        s.name,
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                      trailing: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  )
                  .toList(),
      ),
    );
    if (picked != null && mounted) {
      setState(() => _items.add(picked));
      showAppToast(context, '${picked.symbol} added to watchlist');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  const Spacer(),
                  _CircleIconButton(icon: Icons.add_rounded, onTap: _openAdd),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Watchlist',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _items.isEmpty
                    ? _EmptyState(onAdd: _openAdd)
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final item = _items[i];
                          return Dismissible(
                            key: ValueKey(item.symbol),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => _remove(item),
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: AppColors.accentRedDim,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: AppColors.accentRed,
                              ),
                            ),
                            child: _WatchTile(
                              item: item,
                              onTap: () =>
                                  context.push('/asset/${item.symbol}'),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WatchTile extends StatelessWidget {
  const _WatchTile({required this.item, required this.onTap});

  final _WatchItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = item.isUp ? AppColors.accentGreen : AppColors.accentRed;
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
              _SymbolBadge(symbol: item.symbol),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.symbol,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 56,
                height: 32,
                child: MarketSparkline(
                  points: item.spark,
                  lineColor: color,
                  fillColor: Colors.transparent,
                  showGrid: false,
                  height: 32,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.price,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.change,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
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

class _SymbolBadge extends StatelessWidget {
  const _SymbolBadge({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.bgCardAlt,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        symbol.substring(0, 1),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.button,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.bgCard,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.borderDefault),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.visibility_off_outlined,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            'Your watchlist is empty',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onAdd,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.button,
              side: const BorderSide(color: AppColors.borderDefault),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Add a stock'),
          ),
        ],
      ),
    );
  }
}
