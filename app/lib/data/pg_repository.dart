import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'pg_setup.dart';

/// The only place that knows where data is stored.
/// Screens and state call this; they never touch the database directly.
/// Today: [LocalPgRepository] (on the phone). Next: a Firestore version
/// with offline cache, swapped in without changing any screen.
abstract class PgRepository {
  Future<PgSetup?> loadSetup();
  Future<void> saveSetup(PgSetup setup);
  Future<void> clear();
}

/// Keeps setup answers on this phone (survives closing the app).
class LocalPgRepository implements PgRepository {
  static const _key = 'pg-setup-v1';

  @override
  Future<PgSetup?> loadSetup() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;
    try {
      return PgSetup.fromMap((jsonDecode(raw) as Map).cast<String, Object?>());
    } catch (_) {
      return null; // corrupt or old data: start fresh rather than crash
    }
  }

  @override
  Future<void> saveSetup(PgSetup setup) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(setup.toMap()));
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

/// For tests: keeps data in memory only.
class MemoryPgRepository implements PgRepository {
  PgSetup? saved;

  @override
  Future<PgSetup?> loadSetup() async => saved;

  @override
  Future<void> saveSetup(PgSetup setup) async => saved = setup;

  @override
  Future<void> clear() async => saved = null;
}
