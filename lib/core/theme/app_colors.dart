import 'package:flutter/material.dart';

// Quest-Modern design system tokens (see design.md).
abstract final class AppColors {
  static const bgPrimary = Color(0xFF0C1322);
  static const bgCard = Color(0xFF141B2B);
  static const bgCardAlt = Color(0xFF1E293B);
  static const borderDefault = Color(0xFF475569);
  static const borderSubtle = Color(0xFF334155);
  static const accentGreen = Color(0xFF10B981);
  static const accentGreenDim = Color(0xFF064E3B);
  static const accentPurple = Color(0xFF6366F1);
  static const accentPurpleDim = Color(0xFF4F46E5);
  static const accentAmber = Color(0xFFF59E0B);
  static const accentAmberDim = Color(0xFF78350F);
  static const accentRed = Color(0xFFEF4444);
  static const accentRedDim = Color(0xFF7F1D1D);
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFF94A3B8);
  static const textTertiary = Color(0xFF64748B);
  static const priceUp = accentGreen;
  static const priceDown = accentRed;
  static const xpBadge = accentAmber;
  static const xpBadgeText = Color(0xFF000000);

  static const background = bgPrimary;
  static const backgroundElevated = bgCardAlt;
  static const card = bgCard;
  static const cardBorder = borderDefault;
  static const primary = accentPurple;
  static const primaryPressed = Color(0xFF4F46E5);
  static const button = Color(0xFFE0E7FF);
  static const buttonText = Color(0xFF4F46E5);
  static const accentGold = accentAmber;
  static const success = accentGreen;
  static const danger = accentRed;
  static const textMuted = textTertiary;
  static const inputFill = bgCard;
  static const navBar = bgCard;
  static const divider = borderSubtle;
  static const chartLine = accentGreen;
  static const sparkUp = priceUp;
  static const sparkDown = priceDown;
}
