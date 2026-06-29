import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class ConfirmTradePage extends StatefulWidget {
  const ConfirmTradePage({
    super.key,
    required this.side,
    required this.symbol,
  });

  final String side;
  final String symbol;

  @override
  State<ConfirmTradePage> createState() => _ConfirmTradePageState();
}

class _ConfirmTradePageState extends State<ConfirmTradePage> {
  double _riskLevel = 0.15;

  bool get _isBuy => widget.side.toLowerCase() == 'buy';

  @override
  Widget build(BuildContext context) {
    final confirmColor = _isBuy ? AppColors.accentGreen : AppColors.accentRed;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: _isBuy
                        ? AppColors.accentGreenDim
                        : AppColors.accentRedDim,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    _isBuy
                        ? Icons.add_shopping_cart_rounded
                        : Icons.payments_outlined,
                    size: 34,
                    color: confirmColor,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                _isBuy ? 'Confirm Buy' : 'Confirm Sale',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _isBuy
                    ? 'Review your quest execution details'
                    : 'Finalize your market order for ${widget.symbol}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              MarketPanel(
                child: Column(
                  children: [
                    _DetailRow(label: 'Stock', value: widget.symbol),
                    const Divider(color: AppColors.borderSubtle, height: 22),
                    _DetailRow(
                      label: 'Amount',
                      value: _isBuy ? 'RS 5000' : 'Market Sell',
                    ),
                    const Divider(color: AppColors.borderSubtle, height: 22),
                    _DetailRow(label: 'Shares', value: '10'),
                    const Divider(color: AppColors.borderSubtle, height: 22),
                    _DetailRow(label: 'Type', value: 'Tech'),
                  ],
                ),
              ),
              if (!_isBuy) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.accentPurpleDim,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.accentPurple.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: AppColors.accentPurple.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.emoji_events_rounded,
                          color: AppColors.button,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'QUEST UNLOCK',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.button,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Confirm this sale to complete 'Profit Taker' mission (+500 XP)",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.textPrimary,
                                    height: 1.35,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),
              MarketPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'RISK LEVEL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 20,
                        ),
                        activeTrackColor: AppColors.accentGreen,
                        inactiveTrackColor: AppColors.accentRed.withValues(
                          alpha: 0.45,
                        ),
                        thumbColor: Colors.white,
                        overlayColor: Colors.white.withValues(alpha: 0.1),
                      ),
                      child: Slider(
                        value: _riskLevel,
                        onChanged: (v) => setState(() => _riskLevel = v),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LOW',
                          style: TextStyle(
                            color: AppColors.accentGreen,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'MED',
                          style: TextStyle(
                            color: AppColors.textTertiary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'HIGH',
                          style: TextStyle(
                            color: AppColors.accentRed,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 58,
                child: FilledButton.icon(
                  onPressed: () => context.pushReplacement(
                    '${AppRoutes.tradeResult}?side=${widget.side}&symbol=${widget.symbol}',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: confirmColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  icon: Icon(
                    _isBuy
                        ? Icons.rocket_launch_rounded
                        : Icons.check_rounded,
                    size: 20,
                  ),
                  label: Text(_isBuy ? 'Confirm buy' : 'Confirm sell'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 54,
                child: OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(
                      color: AppColors.borderDefault,
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
