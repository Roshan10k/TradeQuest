import 'package:flutter/material.dart';

abstract final class AppColors {
  static const bgPrimary = Color(0xFF0D1117);
  static const bgCard = Color(0xFF161B22);
  static const bgCardAlt = Color(0xFF1C2128);
  static const borderDefault = Color(0xFF2D333B);
  static const borderSubtle = Color(0xFF21262D);
  static const accentGreen = Color(0xFF4ADE80);
  static const accentGreenDim = Color(0xFF1A3A2A);
  static const accentPurple = Color(0xFF7C6FF7);
  static const accentPurpleDim = Color(0xFF1E1A3A);
  static const accentAmber = Color(0xFFEF9F27);
  static const accentAmberDim = Color(0xFF2A1500);
  static const accentRed = Color(0xFFE24B4A);
  static const accentRedDim = Color(0xFF2A0A0A);
  static const textPrimary = Color(0xFFE6EDF3);
  static const textSecondary = Color(0xFF8B949E);
  static const textTertiary = Color(0xFF484F58);
  static const priceUp = accentGreen;
  static const priceDown = accentRed;
  static const xpBadge = accentAmber;
  static const xpBadgeText = Color(0xFF1A0F00);

  static const background = bgPrimary;
  static const backgroundElevated = bgCardAlt;
  static const card = bgCard;
  static const cardBorder = borderDefault;
  static const primary = accentPurple;
  static const primaryPressed = Color(0xFF6858E8);
  static const button = Color(0xFFC0BBFF);
  static const buttonText = Color(0xFF15109B);
  static const accentGold = accentAmber;
  static const success = accentGreen;
  static const danger = accentRed;
  static const textMuted = textTertiary;
  static const inputFill = bgCardAlt;
  static const navBar = bgCard;
  static const divider = borderSubtle;
  static const chartLine = accentGreen;
  static const sparkUp = priceUp;
  static const sparkDown = priceDown;
}
