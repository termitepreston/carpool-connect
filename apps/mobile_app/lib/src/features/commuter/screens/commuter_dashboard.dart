import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_app/l10n/app_localizations.dart';

class CommuterDashboard extends StatefulWidget {
  const CommuterDashboard({super.key});

  @override
  State<CommuterDashboard> createState() => _CommuterDashboardState();
}

class _CommuterDashboardState extends State<CommuterDashboard> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _destController = TextEditingController();

  bool _isSearching = false;
  bool _isSimulating = false;
  bool _rideInProgress = false;
  bool _showDriverDetails = false;
  bool _rideFinished = false;

  LatLng _carPosition = const LatLng(9.033543, 38.753654); // Piassa
  final List<LatLng> _routePoints = [];
  final List<LatLng> _drivenPoints = [];
  int _currentPointIndex = 0;
  Timer? _simulationTimer;
  
  // For smooth interpolation
  AnimationController? _moveController;
  LatLng? _oldPosition;
  LatLng? _targetPosition;
  
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    _loadRoute();
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  void _loadRoute() {
    final pts = [
      const LatLng(9.033543, 38.753654),
      const LatLng(9.033287, 38.753791),
      const LatLng(9.032877, 38.753996),
      const LatLng(9.032721, 38.754085),
      const LatLng(9.032733, 38.754344),
      const LatLng(9.032957, 38.754602),
      const LatLng(9.033087, 38.754693),
      const LatLng(9.033270, 38.754774),
      const LatLng(9.033468, 38.754801),
      const LatLng(9.034168, 38.754917),
      const LatLng(9.034750, 38.754997),
      const LatLng(9.035095, 38.755053),
      const LatLng(9.035184, 38.755075),
      const LatLng(9.035327, 38.755126),
      const LatLng(9.035896, 38.755445),
      const LatLng(9.036163, 38.755559),
      const LatLng(9.036284, 38.755594),
      const LatLng(9.036911, 38.755728),
      const LatLng(9.037211, 38.755780),
      const LatLng(9.037335, 38.755790),
      const LatLng(9.037428, 38.755782),
      const LatLng(9.037529, 38.755760),
      const LatLng(9.037665, 38.755713),
      const LatLng(9.038105, 38.755492),
      const LatLng(9.038203, 38.755465),
      const LatLng(9.038364, 38.755451),
      const LatLng(9.038602, 38.755468),
      const LatLng(9.038930, 38.755514),
      const LatLng(9.039070, 38.755543),
      const LatLng(9.039356, 38.755632),
      const LatLng(9.039639, 38.755760),
      const LatLng(9.039722, 38.755830),
      const LatLng(9.039779, 38.755916),
      const LatLng(9.039812, 38.756017),
      const LatLng(9.039829, 38.756146),
      const LatLng(9.039810, 38.756267),
      const LatLng(9.039770, 38.756410),
      const LatLng(9.039701, 38.756541),
      const LatLng(9.039608, 38.756634),
      const LatLng(9.039471, 38.756704),
      const LatLng(9.039309, 38.756756),
      const LatLng(9.039122, 38.756776),
      const LatLng(9.038325, 38.756981),
      const LatLng(9.037373, 38.757254),
      const LatLng(9.037131, 38.757352),
      const LatLng(9.036988, 38.757426),
      const LatLng(9.036767, 38.757577),
      const LatLng(9.036616, 38.757697),
      const LatLng(9.036080, 38.758195),
      const LatLng(9.034679, 38.759668),
      const LatLng(9.034591, 38.759767),
      const LatLng(9.034511, 38.759885),
      const LatLng(9.033725, 38.761478),
      const LatLng(9.033001, 38.763103),
      const LatLng(9.033077, 38.763145),
      const LatLng(9.033137, 38.763208),
      const LatLng(9.033177, 38.763286),
      const LatLng(9.034403, 38.763108), // 4 Kilo
    ];
    _routePoints.addAll(pts);
    _drivenPoints.add(pts.first);
  }

  void _checkSimulation() {
    final start = _startController.text.toLowerCase();
    final dest = _destController.text.toLowerCase();

    final isStartPiassa = start == 'piassa' || start == 'ፒያሳ';
    final isDest4Kilo = dest == '4kilo' || dest == '4 kilo' || dest == '4 ኪሎ' || dest == '4ኪሎ';

    if (isStartPiassa && isDest4Kilo) {
      setState(() {
        _isSimulating = true;
        _isSearching = false;
        _carPosition = const LatLng(9.033543, 38.753654);
        _drivenPoints.clear();
        _drivenPoints.add(_carPosition);
      });
      _mapController.move(_carPosition, 16.0);
    } else {
      _searchForRide();
    }
  }

  void _searchForRide() async {
    setState(() => _isSearching = true);
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    
    setState(() => _isSearching = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No ride found. Please try again.')),
    );
  }

  void _startJourney() {
    setState(() {
      _rideInProgress = true;
      _showDriverDetails = false;
      _currentPointIndex = 0;
      _drivenPoints.clear();
      _drivenPoints.add(_routePoints.first);
    });

    _moveController?.duration = const Duration(milliseconds: 1000);
    
    _simulationTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_currentPointIndex < _routePoints.length - 1) {
        _oldPosition = _routePoints[_currentPointIndex];
        _currentPointIndex++;
        _targetPosition = _routePoints[_currentPointIndex];
        
        _moveController?.forward(from: 0).then((_) {
          if (mounted) {
            setState(() {
              _drivenPoints.add(_targetPosition!);
            });
          }
        });

        final dest = _routePoints.last;
        final distance = _calculateDistance(_targetPosition!, dest);
        if (distance < 10) {
          _finishRide();
        }
      } else {
        _finishRide();
      }
    });
  }

  double _calculateDistance(LatLng p1, LatLng p2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((p2.latitude - p1.latitude) * p) / 2 +
        c(p1.latitude * p) * c(p2.latitude * p) *
            (1 - c((p2.longitude - p1.longitude) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  void _finishRide() {
    _simulationTimer?.cancel();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _rideInProgress = false;
          _rideFinished = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    _moveController?.dispose();
    _startController.dispose();
    _destController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _moveController!,
          builder: (context, child) {
            if (_rideInProgress && _oldPosition != null && _targetPosition != null) {
              final lat = _oldPosition!.latitude + (_targetPosition!.latitude - _oldPosition!.latitude) * _moveController!.value;
              final lon = _oldPosition!.longitude + (_targetPosition!.longitude - _oldPosition!.longitude) * _moveController!.value;
              _carPosition = LatLng(lat, lon);
            }
            return FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(9.0300, 38.7400),
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.mobile_app',
                ),
                if (_isSimulating || _rideInProgress || _rideFinished) ...[
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: List.from(_drivenPoints)..add(_carPosition),
                        strokeWidth: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _carPosition,
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            if (!_rideInProgress && !_rideFinished) {
                              setState(() => _showDriverDetails = true);
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                            ),
                            child: Icon(Icons.directions_car, color: Theme.of(context).primaryColor, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (!_isSimulating && !_rideInProgress && !_rideFinished)
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
            );
          },
        ),

        // Route Chooser
        if (!_isSearching && !_isSimulating && !_rideInProgress && !_rideFinished)
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _startController,
                      decoration: InputDecoration(
                        hintText: 'Start (e.g. Piassa)',
                        prefixIcon: const Icon(Icons.my_location, color: Colors.blue),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _destController,
                      decoration: InputDecoration(
                        hintText: 'Destination (e.g. 4 Kilo)',
                        prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _checkSimulation,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Find Ride', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // SOS / Progress Card (Fixed: Moved to bottom and made compact)
        if (_rideInProgress)
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Card(
              elevation: 12,
              color: Theme.of(context).colorScheme.errorContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ride in progress',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                          Text(
                            'Destination: 4 Kilo',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onErrorContainer.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.warning_amber_rounded, size: 20),
                      label: const Text('SOS'),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Driver Details Modal
        if (_showDriverDetails)
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 32, backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1), child: const Text('HS', style: TextStyle(fontWeight: FontWeight.bold))),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Henok Shimelis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              const Text('Toyota Corolla • ABC-123', style: TextStyle(color: Colors.grey)),
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.orange, size: 18),
                                  Text(' 4.9 (124 rides)', style: TextStyle(fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildDetailRow(Icons.route, 'Route', 'Piassa -> 4 Kilo'),
                    _buildDetailRow(Icons.access_time, 'Starts', '08:30 AM'),
                    _buildDetailRow(Icons.event_seat, 'Remaining Seats', '3'),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => setState(() => _showDriverDetails = false),
                            style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _startJourney,
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: const Text('Book Ride'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Finish & Rate
        if (_rideFinished)
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 64),
                    const SizedBox(height: 16),
                    const Text('Arrived at 4 Kilo!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('How was your ride with Henok Shimelis?', textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < _userRating ? Icons.star : Icons.star_border,
                            size: 40,
                            color: Colors.orange,
                          ),
                          onPressed: () => setState(() => _userRating = index + 1.0),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _userRating == 0 ? null : () {
                        setState(() {
                          _rideFinished = false;
                          _isSimulating = false;
                          _startController.clear();
                          _destController.clear();
                          _userRating = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Text('Submit Rating'),
                    ),
                  ],
                ),
              ),
            ),
          ),
            
        if (_isSearching)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
