import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class CommuterDashboard extends StatefulWidget {
  const CommuterDashboard({super.key});

  @override
  State<CommuterDashboard> createState() => _CommuterDashboardState();
}

class _CommuterDashboardState extends State<CommuterDashboard> {
  bool _isSearching = false;
  bool _hasMatch = false;

  void _searchForRide() async {
    setState(() => _isSearching = true);
    // Simulate searching
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    // Simulate match
    setState(() {
      _isSearching = false;
      _hasMatch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Placeholder
        FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(9.0300, 38.7400), // Addis Ababa
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.mobile_app',
            ),
            const MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(9.0300, 38.7400),
                  width: 80,
                  height: 80,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
          ],
        ),
        // Floating Mode Label (Optional, but user said remove AppBar that holds it, so maybe just floating text if they want it)
        
        // Bottom Interaction Card
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!_isSearching && !_hasMatch) ...[
                  Text(AppLocalizations.of(context)!.searchRide, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchRide,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _searchForRide,
                    child: Text(AppLocalizations.of(context)!.searchRide),
                  ),
                ] else if (_isSearching) ...[
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(height: 16),
                  Center(child: Text(AppLocalizations.of(context)!.lookingForDrivers)),
                ] else if (_hasMatch) ...[
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dawit (${AppLocalizations.of(context)!.driver})', style: Theme.of(context).textTheme.titleMedium),
                            const Text('Toyota Vitz • 3 mins away'),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasMatch = false;
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.cancelRide),
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
