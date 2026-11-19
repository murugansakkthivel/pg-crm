import 'package:flutter_test/flutter_test.dart';
import 'package:pg_crm/data/pg_repository.dart';
import 'package:pg_crm/data/pg_setup.dart';
import 'package:pg_crm/main.dart';
import 'package:pg_crm/setup_state.dart';

void main() {
  testWidgets('setup flow: language, PG for, floors, food, due', (tester) async {
    final repo = MemoryPgRepository();
    final state = SetupState(repo);
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
    await tester.pump(const Duration(milliseconds: 400)); // let the save run
    expect(find.text('Your PG is ready!'), findsOneWidget);

    final saved = repo.saved!;
    expect(saved.pgFor, 'ladies');
    expect(saved.floors, 3);
    expect(saved.food, '0');
    expect(saved.due, '1');
    expect(saved.done, isTrue);
  });

  test('saved answers come back when the app reopens', () async {
    final repo = MemoryPgRepository()
      ..saved = const PgSetup(lang: 'kn', step: 2, pgFor: 'gents');
    final state = SetupState(repo);
    await state.load();
    expect(state.lang, 'kn');
    expect(state.current, 'floors');
    expect(state.pgFor, 'gents');
  });

  test('PgSetup survives a round trip through a map', () {
    const a = PgSetup(lang: 'kn', step: 4, pgFor: 'both', floors: 2, food: '3', due: 'join', done: true);
    final b = PgSetup.fromMap(a.toMap());
    expect(b.toMap(), a.toMap());
  });
}
