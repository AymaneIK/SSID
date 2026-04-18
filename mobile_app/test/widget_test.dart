import 'package:flutter_test/flutter_test.dart';

import 'package:ssid/main.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const SSIDApp());
    // Verify the app builds without errors
    expect(find.text('Bonjour 👋'), findsOneWidget);
  });
}
