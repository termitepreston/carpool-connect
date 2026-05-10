import 'dart:math';
import 'logger.dart';

import 'package:models/models.dart';

class MockBackend {
  static final _random = Random();
  static final _failureCounts = <String, int>{};

  /// Simulate network delay
  static Future<void> _delay([int minMs = 800, int maxMs = 2000]) async {
    final ms = minMs + _random.nextInt(maxMs - minMs);
    await Future.delayed(Duration(milliseconds: ms));
  }

  /// Simulate random failures (10% chance), but limit to 2 consecutive failures.
  static void _maybeThrow(String methodName) {
    final currentCount = _failureCounts[methodName] ?? 0;
    
    if (currentCount < 2 && _random.nextDouble() < 0.10) {
      _failureCounts[methodName] = currentCount + 1;
      throw Exception('Network Error: Simulated 500 Internal Server Error');
    }
    
    // Reset failure count on success
    _failureCounts[methodName] = 0;
  }

  static Future<bool> sendOtp(String phone) async {
    AppLogger.info('Sending OTP to $phone...');
    await _delay();
    _maybeThrow('sendOtp');
    AppLogger.info('OTP sent successfully to $phone');
    // Simulate successful OTP send
    return true;
  }

  static Future<User> verifyOtp(String phone, String code) async {
    AppLogger.info('Verifying OTP $code for phone $phone...');
    await _delay();
    _maybeThrow('verifyOtp');
    if (code == '0000') {
      AppLogger.error('Invalid OTP code entered: $code');
      throw Exception('Invalid OTP code');
    }
    AppLogger.info('OTP verified successfully.');
    return User(
      id: 'usr_123',
      name: 'New User',
      phone: phone,
      currentRole: UserRole.commuter,
    );
  }

  static Future<User> setupProfile({
    required String id,
    required String name,
    required UserRole role,
  }) async {
    AppLogger.info('Setting up profile for $name as $role...');
    await _delay();
    _maybeThrow('setupProfile');
    AppLogger.info('Profile setup complete for $name.');
    return User(
      id: id,
      name: name,
      phone: '+251911000000',
      currentRole: role,
    );
  }
}
