import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class GoalSelectionPage extends StatefulWidget {
  const GoalSelectionPage({super.key});

  @override
  State<GoalSelectionPage> createState() => _GoalSelectionPageState();
}

class _GoalSelectionPageState extends State<GoalSelectionPage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 96,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: FlowStepHeader(
                      leading: 'STEP 01 OF 03',
                      trailing: '33% COMPLETE',
                      progress: 0.33,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Set Your Goal',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 26, height: 1.05),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 330),
                child: Text(
                  "We'll tailor your quests based on your motivation.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GoalChoiceCard(
                icon: Icons.school_outlined,
                title: 'Learn the basics',
                subtitle: 'Perfect for absolute beginners starting fresh.',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              const SizedBox(height: 16),
              GoalChoiceCard(
                icon: Icons.trending_up_rounded,
                title: 'Understand trends',
                subtitle: 'Master technical analysis and market cycles.',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              const SizedBox(height: 16),
              GoalChoiceCard(
                icon: Icons.timelapse_rounded,
                title: 'Build a habit',
                subtitle: 'Daily mini-challenges to stay sharp.',
                selected: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
              const SizedBox(height: 16),
              GoalChoiceCard(
                icon: Icons.shield_outlined,
                title: 'Test risk-free',
                subtitle: 'Practice strategies with virtual currency.',
                selected: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
              const SizedBox(height: 24),
              FlowPrimaryButton(
                label: 'Continue',
                icon: Icons.arrow_forward,
                enabled: _selectedIndex >= 0,
                onPressed: () => context.push(AppRoutes.firstTrade),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'ADVENTURE AWAITS',
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.4,
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
