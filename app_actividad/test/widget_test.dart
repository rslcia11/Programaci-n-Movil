import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_actividad/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye la app e inicia el frame
    await tester.pumpWidget(MyApp());

    // Verifica que el contador comienza en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Busca un botón con texto "Incrementar" y haz tap
    final Finder incrementarButton = find.widgetWithText(ElevatedButton, 'Incrementar');
    expect(incrementarButton, findsOneWidget); // Asegura que exista

    await tester.tap(incrementarButton);
    await tester.pump();

    // Verifica que el contador ahora muestra 1
    expect(find.text('1'), findsOneWidget);
  });
}
