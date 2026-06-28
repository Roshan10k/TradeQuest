abstract final class AppRoutes {
  // Onboarding & auth
  static const welcome = '/';
  static const signUp = '/sign-up';
  static const login = '/login';
  static const onboardingGoal = '/onboarding/goal';
  static const firstTrade = '/onboarding/first-trade';
  static const badgeUnlock = '/onboarding/badge-unlock';
  static const otp = '/otp';
  static const pin = '/pin';

  // Main shell tabs
  static const home = '/home';
  static const trade = '/trade';
  static const missions = '/missions';
  static const portfolio = '/portfolio';
  static const profile = '/profile';

  // Stacks
  static const wallet = '/wallet';
  static const settings = '/settings';
  static const help = '/help';
  static const portfolioBreakdown = '/portfolio/breakdown';
  static const watchlist = '/watchlist';
  static const assetDetail = '/asset/:symbol';
  static const advancedChart = '/asset/:symbol/chart';
  static const txHistory = '/transactions';
  static const txDetail = '/transactions/:id';
  static const txSuccess = '/transactions/success';
  static const tradeConfirm = '/trade/confirm';
  static const tradeResult = '/trade/result';
  static const tradeReview = '/trade/review';
  static const leaderboard = '/leaderboard';
  static const notifications = '/notifications';
}
