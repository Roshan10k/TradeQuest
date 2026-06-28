import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/data/demo_market_data.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/app_feedback.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class StockDetailPage extends StatelessWidget {
  const StockDetailPage({super.key, required this.symbol});

  final String symbol;

  DemoStock get _stock {
    switch (symbol) {
      case 'AAPL':
        return const DemoStock(
          symbol: 'AAPL',
          name: 'Apple Inc.',
          exchange: 'NASDAQ',
          price: '\$182.40',
          change: '+2.45%',
          isUp: true,
        );
      case 'MSFT':
        return demoTrendingStocks[1];
      case 'TSLA':
        return demoTrendingStocks[2];
      case 'NVDA':
        return demoTrendingStocks[3];
      default:
        return demoTrendingStocks.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stock = _stock;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreenDim.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.accentGreen.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.trending_up_rounded,
                          size: 16,
                          color: AppColors.accentGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '+2.45%',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.accentGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                stock.name,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 30,
                  height: 1.02,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${stock.symbol}  •  ${stock.exchange.isEmpty ? 'NASDAQ' : stock.exchange}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    stock.price,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'USD',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MarketPanel(
                child: MarketSparkline(
                  points: const [
                    2.1,
                    2.15,
                    2.05,
                    1.95,
                    2.0,
                    2.25,
                    2.55,
                    2.9,
                    2.82,
                    2.68,
                    2.76,
                    2.95,
                  ],
                  lineColor: AppColors.accentGreen,
                  fillColor: AppColors.accentGreenDim.withValues(alpha: 0.7),
                  height: 190,
                ),
              ),
              const SizedBox(height: 16),
              const _TimeframeSelector(),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.75,
                children: const [
                  _MetricCard(title: 'OPEN', value: '\$180.12'),
                  _MetricCard(title: 'VOLUME', value: '52.4M'),
                  _MetricCard(
                    title: 'HIGH',
                    value: '\$183.15',
                    valueColor: AppColors.accentGreen,
                  ),
                  _MetricCard(
                    title: 'LOW',
                    value: '\$179.80',
                    valueColor: AppColors.accentRed,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MarketPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.button,
                          size: 22,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Quest Insights',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.lightbulb_outline_rounded,
                          color: AppColors.textTertiary,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'AAPL is exhibiting strong bullish momentum as it clears the 50-day moving average. Institutional volume is rising, suggesting whales are accumulating before the upcoming product reveal. The technical setup looks like a "cup and handle" pattern, aiming for a test of the \$190 psychological resistance level.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        value: 0.75,
                        backgroundColor: AppColors.bgCardAlt,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accentGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'BULLISH CONFIDENCE',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.button,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          '75%',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppSectionHeader(
                title: 'Recent News',
                actionLabel: 'VIEW ALL',
                onActionTap: () => showAppToast(
                  context,
                  'More news coming soon',
                  icon: Icons.article_outlined,
                  accent: AppColors.button,
                ),
              ),
              const SizedBox(height: 12),
              ...demoRecentNews.map(
                (news) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderDefault),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 66,
                        width: 66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF2A2F3E), Color(0xFF0B101C)],
                          ),
                        ),
                        child: const Icon(
                          Icons.show_chart_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.headline,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontSize: 15, height: 1.2),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${news.timeAgo}  •  ${news.source}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: () => context.push(
                          '${AppRoutes.tradeConfirm}?side=buy&symbol=$symbol',
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accentGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Buy'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: () => context.push(
                          '${AppRoutes.tradeConfirm}?side=sell&symbol=$symbol',
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accentRed,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Sell'),
                      ),
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

class _TimeframeSelector extends StatefulWidget {
  const _TimeframeSelector();

  @override
  State<_TimeframeSelector> createState() => _TimeframeSelectorState();
}

class _TimeframeSelectorState extends State<_TimeframeSelector> {
  static const _labels = ['1D', '1W', '1M', '3M', '1Y', 'ALL'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (var i = 0; i < _labels.length; i++) ...[
            if (i != 0) const SizedBox(width: 8),
            MarketChip(
              label: _labels[i],
              selected: _selected == i,
              onTap: () => setState(() => _selected = i),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  final String title;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return MarketPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 20,
              color: valueColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
