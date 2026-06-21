import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/presentation/shell/main_shell.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/widgets/placeholder_page.dart';
import 'package:tradequest/features/auth/presentation/pages/login_page.dart';
import 'package:tradequest/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tradequest/features/auth/presentation/pages/welcome_page.dart';
import 'package:tradequest/features/onboarding/presentation/pages/badge_unlock_page.dart';
import 'package:tradequest/features/onboarding/presentation/pages/first_trade_page.dart';
import 'package:tradequest/features/onboarding/presentation/pages/goal_selection_page.dart';
import 'package:tradequest/features/trading/presentation/pages/trade_result_page.dart';

class AppRouter {
  AppRouter._();

  static final _rootKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.onboardingGoal,
        builder: (context, state) => const GoalSelectionPage(),
      ),
      GoRoute(
        path: AppRoutes.firstTrade,
        builder: (context, state) => const FirstTradePage(),
      ),
      GoRoute(
        path: AppRoutes.badgeUnlock,
        builder: (context, state) => const BadgeUnlockPage(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const PlaceholderPage(title: 'OTP'),
      ),
      GoRoute(
        path: AppRoutes.pin,
        builder: (context, state) => const PlaceholderPage(title: 'PIN'),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) =>
                    const PlaceholderPage(title: 'Home'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.markets,
                builder: (context, state) =>
                    const PlaceholderPage(title: 'Markets'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.trade,
                builder: (context, state) => const PlaceholderPage(title: 'Trade'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.news,
                builder: (context, state) => const PlaceholderPage(title: 'News'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) =>
                    const PlaceholderPage(title: 'Profile'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.wallet,
        builder: (context, state) => const PlaceholderPage(title: 'Wallet'),
      ),
      GoRoute(
        path: AppRoutes.assetDetail,
        builder: (context, state) => PlaceholderPage(
          title: 'Asset Detail',
          subtitle: state.pathParameters['symbol'] ?? 'BTC',
        ),
      ),
      GoRoute(
        path: AppRoutes.advancedChart,
        builder: (context, state) => PlaceholderPage(
          title: 'Advanced Chart',
          subtitle: state.pathParameters['symbol'] ?? 'BTC',
        ),
      ),
      GoRoute(
        path: AppRoutes.txHistory,
        builder: (context, state) =>
            const PlaceholderPage(title: 'Transaction History'),
      ),
      GoRoute(
        path: AppRoutes.txDetail,
        builder: (context, state) => PlaceholderPage(
          title: 'Transaction Detail',
          subtitle: state.pathParameters['id'] ?? '0',
        ),
      ),
      GoRoute(
        path: AppRoutes.txSuccess,
        builder: (context, state) =>
            const PlaceholderPage(title: 'Transaction Success'),
      ),
      GoRoute(
        path: AppRoutes.tradeResult,
        builder: (context, state) => TradeResultPage(
          side: state.uri.queryParameters['side'] ?? 'buy',
        ),
      ),
      GoRoute(
        path: AppRoutes.leaderboard,
        builder: (context, state) =>
            const PlaceholderPage(title: 'Leaderboard'),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) =>
            const PlaceholderPage(title: 'Notifications'),
      ),
    ],
  );
}
