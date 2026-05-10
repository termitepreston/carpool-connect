import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/src/features/authentication/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:mobile_app/src/shared/providers/theme_provider.dart';
import 'package:mobile_app/src/shared/providers/locale_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 80, 24, 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  child: Icon(Icons.person, size: 80, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.name ?? 'Guest',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  user?.phone ?? 'No phone number',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 32),
                _buildInfoTile(context, Icons.phone_outlined, AppLocalizations.of(context)!.phoneNumber, user?.phone ?? 'N/A'),
                _buildInfoTile(context, Icons.person_outline, AppLocalizations.of(context)!.fullName, user?.name ?? 'N/A'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(AppLocalizations.of(context)!.editProfile),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)]),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              Text(value, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final isDriver = user?.currentRole == UserRole.driver;

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 80, 0, 0),
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(AppLocalizations.of(context)!.profile),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/profile'),
              ),
              ListTile(
                leading: Icon(isDriver ? Icons.drive_eta : Icons.person_pin_circle),
                title: Text(isDriver ? AppLocalizations.of(context)!.driverMode : AppLocalizations.of(context)!.commuterMode),
                trailing: TextButton(
                  onPressed: () {
                    final newRole = isDriver ? UserRole.commuter : UserRole.driver;
                    ref.read(authProvider.notifier).switchRole(newRole);
                  },
                  child: Text(AppLocalizations.of(context)!.switchText),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.brightness_6_outlined),
                title: Text(AppLocalizations.of(context)!.theme),
                trailing: Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (val) => ref.read(themeModeProvider.notifier).toggleTheme(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.language),
                subtitle: Text(locale.languageCode == 'en' ? 'English' : 'አማርኛ'),
                onTap: () => ref.read(localeProvider.notifier).toggleLocale(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(AppLocalizations.of(context)!.about),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/about'),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  AppLocalizations.of(context)!.logout,
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () => ref.read(authProvider.notifier).logout(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.grey),
                title: Text(AppLocalizations.of(context)!.deactivateAccount, style: const TextStyle(color: Colors.grey)),
                onTap: () {},
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.settings,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
