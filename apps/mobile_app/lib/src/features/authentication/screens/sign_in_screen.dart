import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

import '../providers/auth_provider.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _phoneController = TextEditingController(text: '+251911000000');
  bool _acceptedTerms = false;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              // Carpool Connect Logo / Title
              Center(
                child: Column(
                  children: [
                    Icon(Icons.directions_car, size: 64, color: Theme.of(context).primaryColor),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!.appTitle, style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 8),
                    Text(AppLocalizations.of(context)!.tagline, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const Spacer(),
              // Terms of Service Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (val) => setState(() => _acceptedTerms = val ?? false),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(text: AppLocalizations.of(context)!.tosAgreement.split(AppLocalizations.of(context)!.termsOfService)[0]),
                          TextSpan(
                            text: AppLocalizations.of(context)!.termsOfService,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () => context.push('/tos'),
                          ),
                          TextSpan(text: AppLocalizations.of(context)!.tosAgreement.split(AppLocalizations.of(context)!.termsOfService)[1].split(AppLocalizations.of(context)!.privacyPolicy)[0]),
                          TextSpan(
                            text: AppLocalizations.of(context)!.privacyPolicy,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () => context.push('/privacy'),
                          ),
                          TextSpan(text: AppLocalizations.of(context)!.tosAgreement.split(AppLocalizations.of(context)!.privacyPolicy)[1]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Phone Input
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              // Login Button
              ElevatedButton(
                onPressed: (isLoading || !_acceptedTerms)
                    ? null
                    : () async {
                        await ref.read(authProvider.notifier).sendOtp(_phoneController.text);
                        if (context.mounted && ref.read(authProvider).hasError == false) {
                          context.push('/verify-otp?phone=${_phoneController.text}');
                        } else if (context.mounted && ref.read(authProvider).hasError) {
                          _showErrorSnackBar(ref.read(authProvider).error.toString());
                        }
                      },
                child: isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(AppLocalizations.of(context)!.signInWithPhone),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(AppLocalizations.of(context)!.or)),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              // Social Login
              OutlinedButton.icon(
                icon: SvgPicture.asset('assets/images/google_logo.svg', width: 24, height: 24),
                label: Text(AppLocalizations.of(context)!.signInWithGoogle),
                onPressed: !_acceptedTerms ? null : () => _showErrorSnackBar('Google login not implemented yet'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.facebook, size: 24),
                label: Text(AppLocalizations.of(context)!.signInWithFacebook),
                onPressed: !_acceptedTerms ? null : () => _showErrorSnackBar('Facebook login not implemented yet'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
