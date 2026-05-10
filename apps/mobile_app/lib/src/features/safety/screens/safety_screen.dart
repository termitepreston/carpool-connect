import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.safety)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.security, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.safetyPriority,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 48),
            _buildSafetyAction(
              context,
              Icons.sos,
              AppLocalizations.of(context)!.sosEmergency,
              AppLocalizations.of(context)!.sosEmergencyDesc,
              Colors.red,
            ),
            const SizedBox(height: 16),
            _buildSafetyAction(
              context,
              Icons.share_location,
              AppLocalizations.of(context)!.shareLiveTrip,
              AppLocalizations.of(context)!.shareLiveTripDesc,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildSafetyAction(
              context,
              Icons.phone_in_talk,
              AppLocalizations.of(context)!.callSupport,
              AppLocalizations.of(context)!.callSupportDesc,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyAction(BuildContext context, IconData icon, String title, String description, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
