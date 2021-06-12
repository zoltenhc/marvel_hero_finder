import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_hero_finder/main.dart';


void main() {
  testWidgets('Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, "Hulk");
    expect(find.text("Hulk"), findsOneWidget);
    print("Hulk");


    var button = find.text("Hulk");
    expect(button, findsOneWidget);
    print("Searching");
    await tester.tap(button);
    expect(find.text("Hulk"), findsOneWidget);
    print("Found");

  }

  );
}
