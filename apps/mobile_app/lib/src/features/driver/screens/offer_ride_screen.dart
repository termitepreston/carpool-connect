import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class OfferRideScreen extends StatelessWidget {
  const OfferRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.offerRide)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.rideDetails,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.pickup,
                prefixIcon: const Icon(Icons.circle, size: 12, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.destination,
                prefixIcon: const Icon(Icons.location_on, size: 12, color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.date,
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.time,
                      prefixIcon: const Icon(Icons.access_time),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Price per seat (${AppLocalizations.of(context)!.currency})',
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.recurringRide),
              subtitle: Text(AppLocalizations.of(context)!.recurringRideSubtitle),
              value: false,
              onChanged: (val) {},
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: Text(AppLocalizations.of(context)!.publishRide),
            ),
          ],
        ),
      ),
    );
  }
}
