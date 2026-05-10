import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About CarpoolConnect')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'A mobile platform that matches Drivers, everyday vehicle owners willing to share their car, with Commuters seeking affordable, reliable rides along similar routes. Leveraging real-time GPS, route scheduling, and a credit-based reward system, CarpoolConnect transforms underutilized seat capacity into shared value.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            Text(
              'Group Members',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('1. Alazar Abebe', style: TextStyle(fontSize: 16)),
            const Text('2. Alazar G/Medhin', style: TextStyle(fontSize: 16)),
            const Text('3. Amir Siraj', style: TextStyle(fontSize: 16)),
            const Text('4. Biruk Melaku', style: TextStyle(fontSize: 16)),
            const Text('5. Dagmawi Alemayehu', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
