import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class TradeResultPage extends StatelessWidget {
  const TradeResultPage({
    super.key,
    required this.side,
    this.symbol = 'AAPL',
  });

  final String side;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final isSell = side.toLowerCase() == 'sell';

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),
              Center(
                child: Container(
                  height: 82,
                  width: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen.withValues(alpha: 0.95),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreen.withValues(alpha: 0.35),
                        blurRadius: 40,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 44,
                    color: Color(0xFF123D2D),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Trade placed!',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 30, height: 1.05),
              ),
              const SizedBox(height: 8),
              Text(
                isSell
                    ? 'You sold 10 shares of Apple with virtual money.'
                    : 'You bought 10 shares of Apple with virtual money.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
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
                    '+100 XP earned',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              MarketPanel(
                borderColor: AppColors.borderDefault.withValues(alpha: 0.9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'UNDO WINDOW',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.button,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          'UNDO',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.button,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Changed your mind? Undo within 5 seconds.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 7,
                        value: 0.62,
                        backgroundColor: AppColors.bgCardAlt,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 58,
                child: FilledButton(
                  onPressed: () => context.pushReplacement(
                    '${AppRoutes.tradeReview}?side=$side&symbol=$symbol',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.button,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  child: const Text('See trade review'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 58,
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(
                      color: AppColors.borderDefault,
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Back to home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
