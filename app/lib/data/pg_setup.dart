/// The owner's setup answers for one PG.
///
/// Stored as `pgs/{pgId}` in Firestore later (see PROJECT_CONTEXT.md, data model),
/// and as JSON on the phone now. Keep field names the same in both places.
class PgSetup {
  const PgSetup({
    this.lang = 'en',
    this.step = 0,
    this.pgFor,
    this.floors,
    this.food,
    this.due = '1',
    this.done = false,
  });

  final String lang; // en | kn
  final int step; // where the owner stopped in the setup flow
  final String? pgFor; // ladies | gents | both
  final int? floors; // 1..6
  final String? food; // 3 | 2 | 0
  final String due; // 1 | 5 | 10 | join
  final bool done;

  Map<String, Object?> toMap() => {
        'lang': lang,
        'step': step,
        'pgFor': pgFor,
        'floors': floors,
        'food': food,
        'due': due,
        'done': done,
      };

  factory PgSetup.fromMap(Map<String, Object?> m) => PgSetup(
        lang: m['lang'] as String? ?? 'en',
        step: (m['step'] as num?)?.toInt() ?? 0,
        pgFor: m['pgFor'] as String?,
        floors: (m['floors'] as num?)?.toInt(),
        food: m['food'] as String?,
        due: m['due'] as String? ?? '1',
        done: m['done'] as bool? ?? false,
      );
}
