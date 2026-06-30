import 'package:flutter/material.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/core/theme/app_spacing.dart';

class OnboardingBackdrop extends StatelessWidget {
  const OnboardingBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _BaseGradient(),
        Positioned(
          top: -110,
          right: -80,
          child: _Glow(
            size: 250,
            colors: [
              AppColors.accentPurple.withValues(alpha: 0.24),
              Colors.transparent,
            ],
          ),
        ),
        Positioned(
          top: 80,
          left: -120,
          child: _Glow(
            size: 160,
            colors: [
              AppColors.accentPurple.withValues(alpha: 0.15),
              Colors.transparent,
            ],
          ),
        ),
        Positioned(
          bottom: -140,
          right: -100,
          child: _Glow(
            size: 260,
            colors: [
              AppColors.accentGreen.withValues(alpha: 0.15),
              Colors.transparent,
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    required this.child,
    this.scrollable = true,
  });

  final Widget child;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final body = scrollable
        ? SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: child,
          )
        : child;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const Positioned.fill(child: OnboardingBackdrop()),
          SafeArea(bottom: false, child: body),
        ],
      ),
    );
  }
}

class FlowPanel extends StatelessWidget {
  const FlowPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.xl),
    this.borderRadius = 18,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: AppColors.borderDefault.withValues(alpha: 0.9),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66263D7C),
            blurRadius: 30,
            spreadRadius: -10,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}

class FlowPrimaryButton extends StatelessWidget {
  const FlowPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        boxShadow: enabled
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 15,
                ),
              ]
            : null,
      ),
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.buttonText,
          disabledBackgroundColor: AppColors.bgCardAlt,
          disabledForegroundColor: AppColors.textTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.buttonText,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            if (icon != null) ...[
              const SizedBox(width: 10),
              Icon(icon, size: 22),
            ],
          ],
        ),
      ),
    );
  }
}

class FlowSecondaryButton extends StatelessWidget {
  const FlowSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.borderDefault, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          textStyle: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class FlowStepHeader extends StatelessWidget {
  const FlowStepHeader({
    super.key,
    required this.leading,
    required this.trailing,
    required this.progress,
  });

  final String leading;
  final String trailing;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leading,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
            Text(
              trailing,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 4,
            value: progress,
            backgroundColor: AppColors.bgCardAlt,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.button),
          ),
        ),
      ],
    );
  }
}

class GoalChoiceCard extends StatelessWidget {
  const GoalChoiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final background = selected ? const Color(0xFF57E0A6) : AppColors.bgCard;
    final textColor = selected ? Colors.black : AppColors.textPrimary;
    final mutedColor = selected
        ? Colors.black.withValues(alpha: 0.72)
        : AppColors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.borderDefault,
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.black.withValues(alpha: 0.16)
                      : AppColors.bgCardAlt,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: textColor.withValues(alpha: 0.82),
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: mutedColor,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BaseGradient extends StatelessWidget {
  const _BaseGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF10162A), AppColors.bgPrimary],
        ),
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.24),
            blurRadius: 80,
            spreadRadius: 18,
          ),
        ],
      ),
    );
  }
}
