import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.termsOfService)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.termsOfService, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.tosContent),
          ],
        ),
      ),
    );
  }
}
