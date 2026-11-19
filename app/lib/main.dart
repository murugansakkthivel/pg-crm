import 'package:material_ui/material_ui.dart';

import 'data/pg_repository.dart';
import 'setup_screen.dart';
import 'setup_state.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final state = SetupState(LocalPgRepository());
  await state.load(); // reopen where the owner left off
  runApp(PgApp(state: state));
}

class PgApp extends StatefulWidget {
  const PgApp({super.key, required this.state});

  final SetupState state;

  @override
  State<PgApp> createState() => _PgAppState();
}

class _PgAppState extends State<PgApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Save straight away when the owner switches apps or locks the phone.
  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    if (s == AppLifecycleState.paused || s == AppLifecycleState.inactive) {
      widget.state.saveNow();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PG Manager',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: SetupScreen(state: widget.state),
    );
  }
}
