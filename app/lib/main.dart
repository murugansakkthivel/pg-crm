import 'package:material_ui/material_ui.dart';

import 'setup_screen.dart';
import 'setup_state.dart';
import 'theme.dart';

void main() {
  runApp(PgApp(state: SetupState()));
}

class PgApp extends StatelessWidget {
  const PgApp({super.key, required this.state});

  final SetupState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PG Manager',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: SetupScreen(state: state),
    );
  }
}
