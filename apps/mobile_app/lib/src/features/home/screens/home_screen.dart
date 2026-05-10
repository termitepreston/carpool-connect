import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';

import 'package:mobile_app/l10n/app_localizations.dart';

import '../../authentication/providers/auth_provider.dart';
import '../../commuter/screens/commuter_dashboard.dart';
import '../../driver/screens/driver_dashboard.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    if (user == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final isDriver = user.currentRole == UserRole.driver;

    return Scaffold(
      body: isDriver ? const DriverDashboard() : const CommuterDashboard(),
    );
  }
}
