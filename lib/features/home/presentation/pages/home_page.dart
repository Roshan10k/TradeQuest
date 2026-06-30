import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/data/demo_market_data.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/widgets/market_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WELCOME BACK',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 1.4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Commander',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _NotificationBell(
                    onTap: () => context.push(AppRoutes.notifications),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              MarketPanel(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TOTAL PORTFOLIO',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '\$102,480',
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  fontSize: 34,
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
                                '+2.48%',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: AppColors.accentGreen,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Today',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 92,
                      width: 92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.bgCardAlt.withValues(alpha: 0.45),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            top: 12,
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 74,
                              color: AppColors.textTertiary.withValues(
                                alpha: 0.22,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: Icon(
                              Icons.square_outlined,
                              size: 36,
                              color: AppColors.textTertiary.withValues(
                                alpha: 0.18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MarketStatCard(
                      title: 'LEVEL',
                      value: 'Apprentice',
                      subtitle: '450 XP to Next Level',
                      icon: Icons.workspace_premium_rounded,
                      iconColor: AppColors.accentAmber,
                      progress: 0.54,
                      progressColor: AppColors.button,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MarketStatCard(
                      title: 'STREAK',
                      value: '12 Days',
                      subtitle: 'Keep it up!',
                      icon: Icons.local_fire_department_rounded,
                      iconColor: const Color(0xFFFFB2A7),
                      progress: 0.72,
                      progressColor: AppColors.accentGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.button.withValues(alpha: 0.35),
                    style: BorderStyle.solid,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.accentPurpleDim,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: AppColors.button,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TODAY'S MISSION",
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.button,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Buy a stock from the energy sector',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 22,
                                  height: 1.1,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x4D6366F1),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: FilledButton(
                              onPressed: () => context.go(AppRoutes.trade),
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.button,
                                foregroundColor: AppColors.buttonText,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Start mission'),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 18),
                                ],
                              ),
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
                title: 'Watchlist',
                actionLabel: 'VIEW ALL',
                onActionTap: () => context.push(AppRoutes.watchlist),
              ),
              const SizedBox(height: 12),
              ...demoHomeWatchlist.map(
                (stock) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: StockTile(
                    symbol: stock.symbol,
                    name: stock.name,
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

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.onTap});

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
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 24,
              ),
              Positioned(
                right: -1,
                top: -1,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: AppColors.accentRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
