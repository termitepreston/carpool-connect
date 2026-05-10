import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

import '../providers/auth_provider.dart';

class PhoneVerificationScreen extends ConsumerStatefulWidget {
  final String phone;

  const PhoneVerificationScreen({super.key, required this.phone});

  @override
  ConsumerState<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends ConsumerState<PhoneVerificationScreen> {
  final _codeController = TextEditingController(text: '1234'); // Valid OTP

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.verifyPhone)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.verifyPhone, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 8),
            Text('Sent to ${widget.phone}', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 32),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'OTP Code (use 0000 to simulate error)'),
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      ref.read(authProvider.notifier).verifyOtp(widget.phone, _codeController.text);
                    },
              child: isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(AppLocalizations.of(context)!.verify),
            ),
            if (authState.hasError) ...[
              const SizedBox(height: 16),
              Text(authState.error.toString(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
    );
  }
}
