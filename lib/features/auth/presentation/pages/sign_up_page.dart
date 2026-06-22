import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tradequest/core/router/app_routes.dart';
import 'package:tradequest/core/theme/app_colors.dart';
import 'package:tradequest/features/onboarding/presentation/widgets/onboarding_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _accepted = false;
  bool _obscure = true;
  String? _emailError;
  String? _passwordError;
  int _passwordStrength = 0;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _syncValidation() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = email.isEmpty
          ? null
          : !email.contains('@')
          ? 'Enter a valid email address.'
          : null;

      _passwordError = password.isEmpty
          ? null
          : password.length < 8
          ? 'Password must be at least 8 characters.'
          : null;

      _passwordStrength = _computeStrength(password);
    });
  }

  int _computeStrength(String password) {
    if (password.isEmpty) return 0;
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*]').hasMatch(password);

    if (password.length < 6) return 1;
    if (password.length >= 10 && hasNumber && hasSpecial) return 4;
    if (password.length >= 8 && hasNumber) return 3;
    return 2;
  }

  bool get _canSubmit =>
      _accepted &&
      _usernameController.text.trim().isNotEmpty &&
      _emailController.text.contains('@') &&
      _passwordController.text.length >= 8 &&
      _emailError == null &&
      _passwordError == null;

  @override
  Widget build(BuildContext context) {
    final strengthLabel = switch (_passwordStrength) {
      0 => 'NONE',
      1 => 'WEAK',
      2 || 3 => 'FAIR',
      4 => 'STRONG',
      _ => 'NONE',
    };
    final strengthColor = switch (_passwordStrength) {
      1 => AppColors.accentRed,
      2 || 3 => AppColors.accentAmber,
      4 => AppColors.accentGreen,
      _ => AppColors.bgCardAlt,
    };

    return OnboardingScaffold(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 92,
              width: 92,
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x663D4DF2),
                    blurRadius: 34,
                    spreadRadius: -6,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo.png', width: 86, height: 86),
            ),
            const SizedBox(height: 24),
            Text(
              'Start Your Quest',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 27, height: 1.08),
            ),
            const SizedBox(height: 4),
            Text(
              'Level up your financial future.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 26),
            FlowPanel(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FieldLabel(
                    label: 'Username',
                    child: TextField(
                      controller: _usernameController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Choose your alias',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _FieldLabel(
                    label: 'Email Address',
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => _syncValidation(),
                      decoration: InputDecoration(
                        hintText: 'hero@quest.com',
                        errorText: _emailError,
                        prefixIcon: const Icon(Icons.alternate_email_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _FieldLabel(
                    label: 'Password',
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      onChanged: (_) => _syncValidation(),
                      decoration: InputDecoration(
                        hintText: 'Secure your vault',
                        errorText: _passwordError,
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'STRENGTH',
                        style: TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        strengthLabel,
                        style: const TextStyle(
                          color: AppColors.textTertiary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(4, (index) {
                      final active = index < _passwordStrength;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 3),
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: active
                                  ? strengthColor
                                  : AppColors.bgCardAlt,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _accepted,
                    onChanged: (value) =>
                        setState(() => _accepted = value ?? false),
                    title: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.25,
                        ),
                        children: const [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(color: AppColors.button),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(color: AppColors.button),
                          ),
                        ],
                      ),
                    ),
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FlowPrimaryButton(
                    label: 'Create Account',
                    enabled: _canSubmit,
                    onPressed: () => context.push(AppRoutes.onboardingGoal),
                  ),
                  const SizedBox(height: 18),
                  const _DividerLabel(text: 'OR BEGIN WITH'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: 'Google',
                          icon: null,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          label: 'GitHub',
                          trailingText: '⌘',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.login),
                  child: Text(
                    'LOG IN',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.button,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderSubtle)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderSubtle)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingText,
  });

  final String label;
  final VoidCallback onPressed;
  final String? icon;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.borderDefault),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: AppColors.textPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Image.asset(icon!, width: 16, height: 16),
              const SizedBox(width: 8),
            ],
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}
