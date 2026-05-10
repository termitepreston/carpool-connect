import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

void main() {
  test('Logger initialization test', () {
    AppLogger.init();
    expect(true, true); // Basic smoke test for logger
  });
}
