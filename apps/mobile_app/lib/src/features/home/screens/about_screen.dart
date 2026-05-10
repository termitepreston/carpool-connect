import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 80, 24, 24),
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
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'About CarpoolConnect',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
