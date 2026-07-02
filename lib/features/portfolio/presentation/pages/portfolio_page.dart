import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class _Holding {
  const _Holding({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isUp,
  });

  final String symbol;
  final String name;
  final String price;
  final String change;
  final bool isUp;
}

const _holdings = <_Holding>[
  _Holding(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    price: '\$189.45',
    change: '+\$245.20 (4.2%)',
    isUp: true,
  ),
  _Holding(
    symbol: 'MSFT',
    name: 'Microsoft Corp.',
    price: '\$402.12',
    change: '+\$1,102.50 (12.1%)',
    isUp: true,
  ),
  _Holding(
    symbol: 'TSLA',
    name: 'Tesla, Inc.',
    price: '\$175.22',
    change: '-\$82.10 (-1.5%)',
    isUp: false,
  ),
];

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

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
              Text(
                'TOTAL PORTFOLIO VALUE',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$124,592.17',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 40,
                  height: 1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: AppColors.accentGreen,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+2.8% (\$3,402.12) ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.accentGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Today',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const MarketSparkline(
                points: [
                  1.0,
                  0.92,
                  0.98,
                  1.1,
                  1.45,
                  1.3,
                  1.05,
                  0.9,
                  1.2,
                  1.7,
                  2.05,
                  1.85,
                ],
                lineColor: AppColors.accentGreen,
                fillColor: AppColors.accentGreenDim,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: _MetricTile(
                      label: 'CASH BALANCE',
                      value: '\$12,402.00',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _MetricTile(
                      label: 'BUYING POWER',
                      value: '\$49,608.00',
                      valueColor: AppColors.button,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Expanded(
                    child: _MetricTile(label: 'OPEN POSITIONS', value: '14'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _MetricTile(
                      label: 'WIN RATE',
                      value: '68.4%',
                      valueColor: AppColors.accentGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppSectionHeader(
                title: 'Holdings',
                actionLabel: 'VIEW ALL',
                onActionTap: () => context.push(AppRoutes.portfolioBreakdown),
              ),
              const SizedBox(height: 12),
              ..._holdings.map(
                (h) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: StockTile(
                    symbol: h.symbol,
                    name: h.name,
                    price: h.price,
                    change: h.change,
                    isUp: h.isUp,
                    onTap: () => context.push('/asset/${h.symbol}'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _DiversificationBanner(
                onTap: () => context.push(AppRoutes.portfolioBreakdown),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final Color valueColor;

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
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiversificationBanner extends StatelessWidget {
  const _DiversificationBanner({required this.onTap});

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
            border: Border.all(
              color: AppColors.button.withValues(alpha: 0.35),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.pie_chart_rounded,
                    color: AppColors.button,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Diversification Master',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Add 2 more sectors to your portfolio to earn 500 XP and a 'Safe Harbor' badge.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: const LinearProgressIndicator(
                  minHeight: 7,
                  value: 0.6,
                  backgroundColor: AppColors.bgCardAlt,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.button),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '3/5 Sectors',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '60%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.button,
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
