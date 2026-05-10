import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:models/models.dart';
import 'package:mobile_app/l10n/app_localizations.dart';
import 'package:mobile_app/src/features/authentication/providers/auth_provider.dart';
import 'package:mobile_app/src/shared/providers/theme_provider.dart';
import 'package:mobile_app/src/shared/providers/locale_provider.dart';
import 'package:ui_kit/ui_kit.dart';

class MainShellScreen extends ConsumerWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final user = ref.watch(authProvider).value;

    final isDriver = user?.currentRole == UserRole.driver;

    int calculateSelectedIndex(String location) {
      if (location.startsWith('/activities')) return 1;
      if (location.startsWith('/wallet')) return 2;
      if (location.startsWith('/settings')) return isDriver ? 3 : 2;
      return 0;
    }

    void onItemTapped(int index, BuildContext context) {
      final actualIndex = !isDriver && index >= 2 ? index + 1 : index;
      switch (actualIndex) {
        case 0:
          context.go('/home');
          break;
        case 1:
          context.go('/activities');
          break;
        case 2:
          context.go('/wallet');
          break;
        case 3:
          context.go('/settings');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const BrandText(fontSize: 22),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: Icon(Icons.person, size: 40, color: Theme.of(context).primaryColor),
              ),
              accountName: Text(
                user?.name ?? 'Guest',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user?.phone ?? ''),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(AppLocalizations.of(context)!.profile),
                    onTap: () {
                      context.pop();
                      context.push('/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(isDriver ? Icons.drive_eta : Icons.person_pin_circle),
                    title: Text(isDriver ? AppLocalizations.of(context)!.driverMode : AppLocalizations.of(context)!.commuterMode),
                    trailing: TextButton(
                      onPressed: () {
                        final newRole = isDriver ? UserRole.commuter : UserRole.driver;
                        ref.read(authProvider.notifier).switchRole(newRole);
                        context.pop();
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
                      onChanged: (val) {
                        ref.read(themeModeProvider.notifier).toggleTheme();
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context)!.language),
                    subtitle: Text(locale.languageCode == 'en' ? 'English' : 'አማርኛ'),
                    onTap: () {
                      ref.read(localeProvider.notifier).toggleLocale();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(AppLocalizations.of(context)!.about),
                    onTap: () {
                      context.pop();
                      context.push('/about');
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                AppLocalizations.of(context)!.logout,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                ref.read(authProvider.notifier).logout();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: calculateSelectedIndex(location),
        onTap: (index) => onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: AppLocalizations.of(context)!.activities,
          ),
          if (isDriver)
            BottomNavigationBarItem(
              icon: const Icon(Icons.stars_outlined),
              activeIcon: const Icon(Icons.stars),
              label: AppLocalizations.of(context)!.tokens,
            ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
    );
  }
}
