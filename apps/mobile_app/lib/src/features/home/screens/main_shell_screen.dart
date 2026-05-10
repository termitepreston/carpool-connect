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
