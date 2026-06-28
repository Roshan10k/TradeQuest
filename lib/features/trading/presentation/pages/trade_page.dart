import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/data/demo_market_data.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  int _selectedFilter = 0;

  Future<void> _openSearchOverlay() {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Stock search',
      barrierColor: Colors.black.withValues(alpha: 0.72),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
              child: _StockSearchOverlay(
                onStockTap: (stock) {
                  Navigator.of(context).pop();
                  this.context.push('/asset/${stock.symbol}');
                },
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 180),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.98, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _openSearchOverlay,
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.borderDefault),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55263D7C),
                        blurRadius: 28,
                        spreadRadius: -10,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Search Markets...',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    MarketChip(
                      label: 'All Assets',
                      selected: _selectedFilter == 0,
                      onTap: () => setState(() => _selectedFilter = 0),
                    ),
                    const SizedBox(width: 10),
                    MarketChip(
                      label: 'Tech',
                      selected: _selectedFilter == 1,
                      onTap: () => setState(() => _selectedFilter = 1),
                    ),
                    const SizedBox(width: 10),
                    MarketChip(
                      label: 'Energy',
                      selected: _selectedFilter == 2,
                      onTap: () => setState(() => _selectedFilter = 2),
                    ),
                    const SizedBox(width: 10),
                    MarketChip(
                      label: 'Health',
                      selected: _selectedFilter == 3,
                      onTap: () => setState(() => _selectedFilter = 3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF201B12),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.accentAmber.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: AppColors.accentAmberDim,
                        borderRadius: BorderRadius.circular(42),
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: AppColors.accentAmber,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trading Tip',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.accentAmber,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Diversification is your shield. By spreading capital across different sectors like Tech and Health, you minimize the impact of a single asset's decline.",
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.35,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AppSectionHeader(
                title: 'Trending Stocks',
                actionLabel: 'View All',
                onActionTap: () => showAppToast(
                  context,
                  'Full market list coming soon',
                  icon: Icons.show_chart_rounded,
                  accent: AppColors.button,
                ),
              ),
              const SizedBox(height: 12),
              ...demoTrendingStocks.map(
                (stock) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: StockTile(
                    symbol: stock.symbol,
                    name: stock.name,
                    exchange: stock.exchange.isEmpty ? null : stock.exchange,
                    price: stock.price,
                    change: stock.change,
                    isUp: stock.isUp,
                    onTap: () => context.push('/asset/${stock.symbol}'),
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

class _StockSearchOverlay extends StatelessWidget {
  const _StockSearchOverlay({required this.onStockTap});

  final ValueChanged<DemoStock> onStockTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 430),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.button.withValues(alpha: 0.5),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99263D7C),
            blurRadius: 40,
            spreadRadius: -12,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.button.withValues(alpha: 0.85),
                      width: 1.1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'AAPL',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                      const Icon(
                        Icons.close_rounded,
                        color: AppColors.textSecondary,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      'RECENT SEARCHES',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'CLEAR ALL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.button,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    _RecentChip(label: 'TSLA'),
                    SizedBox(width: 8),
                    _RecentChip(label: 'NVDA'),
                    SizedBox(width: 8),
                    _RecentChip(label: 'BTC'),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  'TOP RESULTS',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                ...demoSearchResults.map(
                  (stock) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: StockTile(
                      symbol: stock.symbol,
                      name: stock.name,
                      exchange: stock.exchange.isEmpty ? null : stock.exchange,
                      price: stock.price,
                      change: stock.change,
                      isUp: stock.isUp,
                      onTap: () => onStockTap(stock),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentChip extends StatelessWidget {
  const _RecentChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.accentGreen,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
