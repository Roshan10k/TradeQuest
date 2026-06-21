import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class FirstTradePage extends StatefulWidget {
  const FirstTradePage({super.key});

  @override
  State<FirstTradePage> createState() => _FirstTradePageState();
}

class _FirstTradePageState extends State<FirstTradePage> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      scrollable: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlowStepHeader(
              leading: 'STEP 2 OF 3',
              trailing: 'TRADE SIMULATION',
              progress: 0.66,
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your first trade',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 26, height: 1.05),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                "Let's buy Apple together. Don't worry - it's virtual.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 22),
            FlowPanel(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AAPL',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Apple Inc.',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'NRS 180',
                            style: TextStyle(
                              color: AppColors.accentGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '↗ +2.4% Today',
                            style: TextStyle(
                              color: AppColors.accentGreen,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    child: CustomPaint(
                      painter: _PriceChartPainter(),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const _AmountLabel(),
            const SizedBox(height: 8),
            SizedBox(
              height: 74,
              child: TextField(
                controller: _amountController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(color: AppColors.textTertiary, fontSize: 22),
                  filled: true,
                  fillColor: AppColors.bgCard.withValues(alpha: 0.9),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.borderDefault.withValues(alpha: 0.7),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accentAmberDim,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: AppColors.accentAmber,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VIRTUAL BALANCE',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppColors.textTertiary,
                                letterSpacing: 1.2,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'NRS 1,00,000',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 19),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bgCardAlt,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'SAFE',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderDefault),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.button,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Virtual trading uses real market data but fake money. It's the perfect way to practice without risk.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FlowPrimaryButton(
              label: 'Place my first trade',
              onPressed: () => context.push(AppRoutes.badgeUnlock),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountLabel extends StatelessWidget {
  const _AmountLabel();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Enter amount: Rs.',
      style: TextStyle(
        color: AppColors.textSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _PriceChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.accentGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.accentGreen.withValues(alpha: 0.24),
          AppColors.accentGreen.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final axisPaint = Paint()
      ..color = AppColors.borderSubtle.withValues(alpha: 0.8)
      ..strokeWidth = 1;

    for (var i = 0; i < 4; i++) {
      final y = size.height * (0.25 + i * 0.18);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    final points = <Offset>[
      Offset(0, size.height * 0.74),
      Offset(size.width * 0.1, size.height * 0.64),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.3, size.height * 0.54),
      Offset(size.width * 0.42, size.height * 0.61),
      Offset(size.width * 0.53, size.height * 0.41),
      Offset(size.width * 0.66, size.height * 0.38),
      Offset(size.width * 0.78, size.height * 0.29),
      Offset(size.width * 0.91, size.height * 0.33),
      Offset(size.width, size.height * 0.31),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final areaPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(areaPath, fillPaint);
    canvas.drawPath(linePath, linePaint);

    final pointPaint = Paint()..color = AppColors.accentGreen;
    canvas.drawCircle(points[7], 3.5, pointPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
