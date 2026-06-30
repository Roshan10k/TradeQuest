import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';

class TradeReviewPage extends StatelessWidget {
  const TradeReviewPage({super.key, required this.side, required this.symbol});

  final String side;
  final String symbol;

  bool get _isBuy => side.toLowerCase() == 'buy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isBuy ? 'Buy Review' : 'Sale Review',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 6),
              Text(
                'Detailed breakdown of your $symbol ${_isBuy ? 'purchase' : 'sale'}.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 26),
              _ReviewSection(
                label: 'WHAT HAPPENED',
                child: Text(
                  _isBuy
                      ? 'You bought $symbol after positive earnings — a momentum trade. Good trading.'
                      : 'You sold $symbol after it reached your target price — a disciplined exit. Good trading.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _ReviewSection(
                label: 'CONCEPT PRACTICED',
                child: const Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    _ConceptChip(label: 'Momentum trading'),
                    _ConceptChip(label: 'Reading charts'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _ReviewSection(
                label: 'OUTCOME',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _PriceColumn(
                          label: 'Bought at',
                          value: _isBuy ? 'Rs. 180' : '\$180',
                          valueColor: AppColors.textPrimary,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                        _PriceColumn(
                          label: _isBuy ? 'Current' : 'Sold at',
                          value: _isBuy ? 'Rs. 190' : '\$192.50',
                          valueColor: AppColors.accentGreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (_isBuy)
                      const Text(
                        '+10 unrealised gain',
                        style: TextStyle(
                          color: AppColors.accentGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else ...[
                      Text(
                        'Realised Gain',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '+\$12.50 / share',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.accentGreen,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _ReviewSection(
                label: 'RATING',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < 3
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: i < 3
                              ? AppColors.accentAmber
                              : AppColors.textTertiary,
                          size: 28,
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Good timing! Try checking volume next time.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: Color(0x4D6366F1), blurRadius: 15),
                  ],
                ),
                child: FilledButton.icon(
                  onPressed: () => context.go(AppRoutes.home),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  icon: const Icon(Icons.grid_view_rounded, size: 20),
                  label: const Text('Go to Dashboard'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PriceColumn extends StatelessWidget {
  const _PriceColumn({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _ConceptChip extends StatelessWidget {
  const _ConceptChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bgCardAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.borderDefault),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
