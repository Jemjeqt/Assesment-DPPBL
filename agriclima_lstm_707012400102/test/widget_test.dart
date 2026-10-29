import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_707012400102/main.dart';

void main() {
  testWidgets('AplikasiAgriClima smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiAgriClima());
    await tester.pumpAndSettle();

    expect(find.text('AgriClima — Beranda'), findsOneWidget);
    expect(find.text('Selamat Datang di AgriClima LSTM'), findsOneWidget);
  });
}
