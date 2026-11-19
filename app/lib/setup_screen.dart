import 'package:material_ui/material_ui.dart';

import 'setup_state.dart';
import 'strings.dart';
import 'theme.dart';
import 'widgets.dart';

/// One question per screen. Tap to answer. The owner never types.
class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key, required this.state});

  final SetupState state;

  static const _qKey = {
    'lang': 'q_lang', 'for': 'q_for', 'floors': 'q_floors', 'food': 'q_food', 'due': 'q_due',
  };
  static const _qIcon = {
    'lang': Icons.language, 'for': Icons.groups_outlined, 'floors': Icons.apartment_outlined,
    'food': Icons.restaurant_outlined, 'due': Icons.calendar_today_outlined,
  };

  void _soon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(state.t('voiceSoon'))));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final st = state;
        final s = st.current;
        return PopScope(
          canPop: st.step == 0 && !st.done,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) st.back();
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: st.done
                    ? _DoneView(state: st)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _TopBar(state: st, onSpeak: () => _soon(context)),
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.only(top: 22),
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    decoration: const BoxDecoration(color: C.pl, shape: BoxShape.circle),
                                    child: Icon(_qIcon[s], color: C.p, size: 32),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(st.t(_qKey[s]!),
                                    style: Theme.of(context).textTheme.headlineSmall),
                                const SizedBox(height: 22),
                                ..._body(context, st, s),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(children: [
                            CircleIconButton(
                                icon: Icons.mic_none, label: st.t('a_mic'), onTap: () => _soon(context)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 64,
                                child: FilledButton(
                                  onPressed: st.canNext ? st.next : null,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: C.btn,
                                    foregroundColor: C.btnt,
                                    disabledBackgroundColor: C.btn.withValues(alpha: 0.45),
                                    disabledForegroundColor: C.btnt.withValues(alpha: 0.6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                                  ),
                                  child: Text(st.isLast ? st.t('finish') : st.t('next')),
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _body(BuildContext context, SetupState st, String s) {
    Widget gap(Widget w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w);
    Widget note(String key) =>
        Text(st.t(key), style: Theme.of(context).textTheme.bodySmall);

    switch (s) {
      case 'lang':
        return [
          for (final l in langs)
            gap(OptionButton(
              label: l.label,
              sub: l.soon ? st.t('soonLang') : null,
              selected: st.lang == l.id,
              onTap: l.soon ? null : () => st.update(() => st.lang = l.id),
            )),
        ];
      case 'for':
        return [
          for (final (v, icon) in [
            ('ladies', Icons.person_outline),
            ('gents', Icons.person_outline),
            ('both', Icons.groups_outlined),
          ])
            gap(OptionButton(
              label: st.t(v),
              icon: icon,
              selected: st.pgFor == v,
              onTap: () => st.update(() => st.pgFor = v),
            )),
        ];
      case 'floors':
        return [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.4,
            children: [
              for (var n = 1; n <= 6; n++)
                ChoiceChipButton(
                  label: '$n',
                  big: true,
                  selected: st.floors == n,
                  onTap: () => st.update(() => st.floors = n),
                ),
            ],
          ),
          const SizedBox(height: 10),
          note('count_ground'),
        ];
      case 'food':
        return [
          for (final (v, icon) in [
            ('3', Icons.restaurant_outlined),
            ('2', Icons.restaurant_outlined),
            ('0', Icons.no_meals_outlined),
          ])
            gap(OptionButton(
              label: st.t('f$v'),
              icon: icon,
              selected: st.food == v,
              onTap: () => st.update(() => st.food = v),
            )),
        ];
      case 'due':
        return [
          for (final (v, key, icon) in [
            ('1', 'd1', Icons.calendar_today_outlined),
            ('5', 'd5', Icons.calendar_today_outlined),
            ('10', 'd10', Icons.calendar_today_outlined),
            ('join', 'dj', Icons.person_outline),
          ])
            gap(OptionButton(
              label: st.t(key),
              icon: icon,
              selected: st.due == v,
              onTap: () => st.update(() => st.due = v),
            )),
          note('due_note'),
        ];
    }
    return const [];
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.state, required this.onSpeak});

  final SetupState state;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    final st = state;
    final n = st.step + 1;
    return Row(children: [
      st.step > 0
          ? CircleIconButton(icon: Icons.arrow_back, label: st.t('a_back'), onTap: st.back)
          : const SizedBox(width: 44, height: 44),
      const SizedBox(width: 10),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(st.t('step', {'a': n, 'b': steps.length}),
              style: const TextStyle(fontSize: 13, color: C.q)),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: n / steps.length,
              minHeight: 6,
              color: C.p,
              backgroundColor: C.track,
            ),
          ),
        ]),
      ),
      const SizedBox(width: 10),
      if (st.step > 0) ...[
        _LangChip(state: st),
        const SizedBox(width: 10),
      ],
      CircleIconButton(icon: Icons.volume_up_outlined, label: st.t('a_speak'), onTap: onSpeak, tint: true),
    ]);
  }
}

/// Small globe + language name chip. Opens a sheet to switch language any time.
class _LangChip extends StatelessWidget {
  const _LangChip({required this.state});

  final SetupState state;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: state.t('a_lang'),
      child: Material(
        color: Colors.white,
        shape: const StadiumBorder(side: BorderSide(color: C.bd)),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            builder: (ctx) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  for (final l in langs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: OptionButton(
                        label: l.label,
                        sub: l.soon ? state.t('soonLang') : null,
                        selected: state.lang == l.id,
                        onTap: l.soon
                            ? null
                            : () {
                                state.update(() => state.lang = l.id);
                                Navigator.pop(ctx);
                              },
                      ),
                    ),
                ]),
              ),
            ),
          ),
          child: SizedBox(
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.language, size: 16, color: C.p),
                const SizedBox(width: 6),
                Text(state.t('langName'),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _DoneView extends StatelessWidget {
  const _DoneView({required this.state});

  final SetupState state;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 16),
      Row(children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(color: C.p, shape: BoxShape.circle),
          child: const Icon(Icons.check, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(state.t('ready'), style: Theme.of(context).textTheme.headlineSmall)),
      ]),
      const SizedBox(height: 16),
      Text(state.t('soon'), style: Theme.of(context).textTheme.bodySmall),
      const Spacer(),
      TextButton(onPressed: state.back, child: Text(state.t('edit'))),
    ]);
  }
}
