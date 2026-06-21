import 'package:flutter_test/flutter_test.dart';
import 'package:tradequest/app.dart';

void main() {
  testWidgets('Pixel-Tune app builds', (tester) async {
    await tester.pumpWidget(const PixelTuneApp());
    expect(find.byType(PixelTuneApp), findsOneWidget);
  });
}
