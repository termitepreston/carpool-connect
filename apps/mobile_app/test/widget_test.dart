import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: CarpoolConnectApp()));

    // Verify that we are on the splash screen or similar (basic check)
    expect(find.byType(CarpoolConnectApp), findsOneWidget);
    
    // Clean up timers
    await tester.pumpAndSettle(const Duration(seconds: 10));
  });
}
