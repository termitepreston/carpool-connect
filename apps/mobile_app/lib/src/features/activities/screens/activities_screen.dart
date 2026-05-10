import 'package:flutter/material.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.activeTrips),
              Tab(text: AppLocalizations.of(context)!.rideHistory),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildActiveTrips(context),
                _buildHistory(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTrips(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.noActiveTrips),
        ],
      ),
    );
  }

  Widget _buildHistory(BuildContext context) {
    final locations = [
      ['Bole', 'Piazza'],
      ['Megenagna', '4 Kilo'],
      ['CMC', 'Mexico'],
      ['Sarbet', 'Stadium'],
      ['Piasa', 'Bole Atlas'],
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        final loc = locations[index % locations.length];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('May ${10 - index}, 2026', style: Theme.of(context).textTheme.bodySmall),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(AppLocalizations.of(context)!.completed, style: const TextStyle(color: Colors.green, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      children: [
                        const Icon(Icons.circle, size: 12, color: Colors.blue),
                        Container(width: 2, height: 20, color: Colors.grey),
                        const Icon(Icons.location_on, size: 12, color: Colors.red),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loc[0], style: const TextStyle(fontWeight: FontWeight.w500)),
                          const SizedBox(height: 16),
                          Text(loc[1], style: const TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 16)),
                        const SizedBox(width: 8),
                        Text(index % 2 == 0 ? 'Dawit' : 'Elias'),
                      ],
                    ),
                    Text(
                      '${(index + 1) * 10} ${AppLocalizations.of(context)!.tokens}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
