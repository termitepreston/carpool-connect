import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class DocumentVerificationScreen extends StatelessWidget {
  const DocumentVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.verification)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.verifyIdentity,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.verificationSubtitle,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 48),
            _buildDocItem(context, AppLocalizations.of(context)!.drivingLicense, Icons.drive_eta),
            const SizedBox(height: 16),
            _buildDocItem(context, AppLocalizations.of(context)!.nationalId, Icons.badge),
            const SizedBox(height: 16),
            _buildDocItem(context, AppLocalizations.of(context)!.vehicleRegistration, Icons.description),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.submitForReview),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocItem(BuildContext context, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500))),
          const Icon(Icons.upload_file, color: Colors.grey),
        ],
      ),
    );
  }
}
