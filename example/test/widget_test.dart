import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('example app shows dotted decoration samples', (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Dotted Decoration'), findsOneWidget);
    expect(find.text('Bottom Line'), findsOneWidget);
    expect(find.text('Left Line'), findsOneWidget);
    expect(find.text('Rounded Box'), findsOneWidget);
    expect(find.text('Custom Rounded Box'), findsOneWidget);
    expect(find.text('Box with background'), findsOneWidget);
    expect(find.text('Oval with dotted outline'), findsOneWidget);
  });
}
