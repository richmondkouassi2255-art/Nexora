import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nexora/app/app.dart';

void main() {
  testWidgets('Nexora app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: NexoraApp(),
      ),
    );

    expect(find.text('Accueil'), findsOneWidget);
  });
}
