import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/theme/app_spacing.dart';

abstract final class AppTheme {
  static ThemeData get dark {
    final base = GoogleFonts.spaceGroteskTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.bgCard,
        primary: AppColors.accentPurple,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.accentGreen,
        onSurface: AppColors.textPrimary,
        outline: AppColors.borderDefault,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: base.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      textTheme: TextTheme(
        displayMedium: base.displayMedium?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          height: 1.12,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: base.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: base.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 15,
          height: 1.45,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
        labelLarge: base.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.15,
        ),
        labelSmall: base.labelSmall?.copyWith(
          color: AppColors.textTertiary,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
        bodySmall: base.bodySmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.35,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(color: AppColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.accentPurple,
            width: 1.5,
          ),
        ),
        errorStyle: base.bodySmall?.copyWith(
          color: AppColors.accentRed,
          fontSize: 12,
        ),
        hintStyle: base.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
          fontSize: 14,
        ),
        labelStyle: base.labelSmall?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.accentPurple;
          }
          return AppColors.bgCardAlt;
        }),
        side: const BorderSide(color: AppColors.borderDefault),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
