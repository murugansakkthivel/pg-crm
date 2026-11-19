import 'package:material_ui/material_ui.dart';

/// The only colours the app uses (see PROJECT_CONTEXT.md, section 3).
/// Do not add new colours.
class C {
  static const p = Color(0xFF3D86D9); // primary: selected borders, icons, progress
  static const pl = Color(0xFFEAF4FF); // tint: selected background, icon circles
  static const btn = Color(0xFF9CCBFF); // main Next button
  static const btnt = Color(0xFF0F2A44); // text on the Next button
  static const a = Color(0xFFE08A2E); // amber: "Rent due" only
  static const ink = Color(0xFF1A1F2B); // body text
  static const q = Color(0xFF5A6272); // secondary text
  static const bd = Color(0xFFD7DCE4); // borders
  static const bg = Color(0xFFF4F7FB); // page/card background
  static const track = Color(0xFFE4E9F0); // progress track
}

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: C.p,
      primary: C.p,
      surface: Colors.white,
      onSurface: C.ink,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 26, height: 1.3, fontWeight: FontWeight.w700, color: C.ink),
      titleMedium: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: C.ink),
      bodyMedium: TextStyle(fontSize: 16, color: C.ink),
      bodySmall: TextStyle(fontSize: 14, height: 1.45, color: C.q),
    ),
  );
}
