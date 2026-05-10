import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  testWidgets('BrandText displays correct text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BrandText(),
        ),
      ),
    );

    expect(find.text('CarpoolConnect'), findsOneWidget);
  });
}
