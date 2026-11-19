import 'dart:async';

import 'package:material_ui/material_ui.dart';

import 'data/pg_repository.dart';
import 'data/pg_setup.dart';
import 'strings.dart' as s;

/// Steps built so far. The rest of the 12-screen flow (phone, location,
/// rooms, room types, rent, deposit, bed board) is added one by one.
const steps = ['lang', 'for', 'floors', 'food', 'due'];

/// All answers from the owner setup flow. Saves through [PgRepository]
/// shortly after every change, and restores them when the app opens.
class SetupState extends ChangeNotifier {
  SetupState(this.repo);

  final PgRepository repo;
  Timer? _saveTimer;

  String lang = 'en';
  int step = 0;
  String? pgFor; // ladies | gents | both
  int? floors; // 1..6
  String? food; // 3 | 2 | 0
  String due = '1'; // 1 | 5 | 10 | join  (smart default: 1st)
  bool done = false;

  String t(String key, [Map<String, Object> v = const {}]) => s.t(lang, key, v);

  String get current => steps[step];
  bool get isLast => step == steps.length - 1;

  bool get canNext => switch (current) {
        'for' => pgFor != null,
        'floors' => floors != null,
        'food' => food != null,
        _ => true,
      };

  PgSetup toSetup() => PgSetup(
        lang: lang, step: step, pgFor: pgFor, floors: floors, food: food, due: due, done: done);

  /// Restore saved answers (call once at start).
  Future<void> load() async {
    final saved = await repo.loadSetup();
    if (saved == null) return;
    lang = saved.lang;
    step = saved.step.clamp(0, steps.length - 1);
    pgFor = saved.pgFor;
    floors = saved.floors;
    food = saved.food;
    due = saved.due;
    done = saved.done;
    notifyListeners();
  }

  void update(void Function() change) {
    change();
    notifyListeners();
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 300), saveNow);
  }

  Future<void> saveNow() {
    _saveTimer?.cancel();
    return repo.saveSetup(toSetup());
  }

  void next() => update(() {
        if (isLast) {
          done = true;
        } else {
          step++;
        }
      });

  void back() => update(() {
        if (done) {
          done = false;
        } else if (step > 0) {
          step--;
        }
      });

  @override
  void dispose() {
    _saveTimer?.cancel();
    super.dispose();
  }
}
