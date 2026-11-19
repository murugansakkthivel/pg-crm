import 'package:flutter_test/flutter_test.dart';
import 'package:pg_crm/main.dart';
import 'package:pg_crm/setup_state.dart';

void main() {
  testWidgets('setup flow: language, PG for, floors, food, due', (tester) async {
    final state = SetupState();
    await tester.pumpWidget(PgApp(state: state));

    expect(find.text('Choose your language'), findsOneWidget);
    await tester.tap(find.text('ಕನ್ನಡ'));
    await tester.pump();
    expect(find.text('ಭಾಷೆ ಆಯ್ಕೆ ಮಾಡಿ'), findsOneWidget); // one language at a time
    await tester.tap(find.text('English'));
    await tester.pump();

    await tester.tap(find.text('Next'));
    await tester.pump();
    expect(find.text('Who is your PG for?'), findsOneWidget);
    expect(state.canNext, isFalse);
    await tester.tap(find.text('Ladies'));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pump();

    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pump();

    await tester.tap(find.text('No food'));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pump();

    expect(find.text('Which day is rent due?'), findsOneWidget);
    await tester.tap(find.text('Finish setup'));
    await tester.pump();
    expect(find.text('Your PG is ready!'), findsOneWidget);
    expect(state.pgFor, 'ladies');
    expect(state.floors, 3);
    expect(state.food, '0');
    expect(state.due, '1');
  });
}
