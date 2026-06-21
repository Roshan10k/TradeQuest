import 'package:flutter/material.dart';
import 'package:tradequest/core/router/app_router.dart';
import 'package:tradequest/core/theme/app_theme.dart';

class PixelTuneApp extends StatelessWidget {
  const PixelTuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pixel-Tune',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
