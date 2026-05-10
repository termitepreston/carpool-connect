import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:models/models.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

import '../providers/auth_provider.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  UserRole _selectedRole = UserRole.commuter;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.setupProfile)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.tellUsAboutYourself, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.fullName),
            ),
            const SizedBox(height: 24),
            Text(AppLocalizations.of(context)!.howWillYouUseApp, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedRole == UserRole.commuter ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
                      side: BorderSide(
                        color: _selectedRole == UserRole.commuter ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () => setState(() => _selectedRole = UserRole.commuter),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/commuter.svg', width: 64, height: 64),
                          const SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.commuter),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: _selectedRole == UserRole.driver ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : null,
                      side: BorderSide(
                        color: _selectedRole == UserRole.driver ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () => setState(() => _selectedRole = UserRole.driver),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/images/driver.svg', width: 64, height: 64),
                          const SizedBox(height: 8),
                          Text(AppLocalizations.of(context)!.driver),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (_nameController.text.isNotEmpty) {
                        ref.read(authProvider.notifier).setupProfile(_nameController.text, _selectedRole);
                      }
                    },
              child: isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(AppLocalizations.of(context)!.completeSetup),
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
