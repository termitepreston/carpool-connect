import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  bool _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Placeholder
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(9.0300, 38.7400),
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.mobile_app',
            ),
          ],
        ),
        // Online toggle bar (Floating)
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isOnline ? AppLocalizations.of(context)!.online : AppLocalizations.of(context)!.offline,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _isOnline ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: _isOnline,
                    onChanged: (val) => setState(() => _isOnline = val),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isOnline)
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.waitingForRequests,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
