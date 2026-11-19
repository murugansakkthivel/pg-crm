import 'package:material_ui/material_ui.dart';

import 'strings.dart' as s;

/// Steps built so far. The rest of the 12-screen flow (phone, location,
/// rooms, room types, rent, deposit, bed board) is added one by one.
const steps = ['lang', 'for', 'floors', 'food', 'due'];

/// All answers from the owner setup flow. Matches the web app's data model.
class SetupState extends ChangeNotifier {
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

  void update(void Function() change) {
    change();
    notifyListeners();
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
}
