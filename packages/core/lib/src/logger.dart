import 'dart:developer' as developer;
import 'package:logging/logging.dart';

class AppLogger {
  static final Logger _logger = Logger('CarpoolConnect');
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;
    
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      developer.log(
        record.message,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        level: record.level.value,
        name: record.loggerName,
        zone: record.zone,
        error: record.error,
        stackTrace: record.stackTrace,
      );
      // Also print to console for mockup debugging
      print('[${record.level.name}] ${record.time}: ${record.message}');
      if (record.error != null) {
        print('Error: ${record.error}');
      }
    });
    _initialized = true;
    _logger.info('AppLogger initialized.');
  }

  static void info(String message) => _logger.info(message);
  static void warning(String message) => _logger.warning(message);
  static void error(String message, [Object? error, StackTrace? stackTrace]) => _logger.severe(message, error, stackTrace);
  static void fine(String message) => _logger.fine(message);
}
