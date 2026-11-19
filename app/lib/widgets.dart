import 'package:material_ui/material_ui.dart';

import 'theme.dart';

/// Big tap-to-answer row (about 64 px tall) with an optional icon and a tick when selected.
class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.sub,
  });

  final String label;
  final String? sub;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return Semantics(
      button: true,
      selected: selected,
      child: Opacity(
        opacity: disabled ? 0.45 : 1,
        child: Material(
          color: selected ? C.pl : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: selected ? C.p : C.bd, width: selected ? 3 : 2),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 64),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(children: [
                  if (icon != null) ...[Icon(icon, color: C.p, size: 28), const SizedBox(width: 14)],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(label, style: Theme.of(context).textTheme.titleMedium),
                        if (sub != null) Text(sub!, style: const TextStyle(fontSize: 13, color: C.q)),
                      ],
                    ),
                  ),
                  if (selected)
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(color: C.p, shape: BoxShape.circle),
                      child: const Icon(Icons.check, color: Colors.white, size: 18),
                    ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Square-ish chip used in grids (floors 1–6, yes/no, amounts).
class ChoiceChipButton extends StatelessWidget {
  const ChoiceChipButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.big = false,
  });

  final String label;
  final bool selected, big;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? C.pl : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: selected ? C.p : C.bd, width: selected ? 3 : 2),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: SizedBox(
            height: big ? 72 : 56,
            child: Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: big ? 26 : 17, fontWeight: FontWeight.w700, color: C.ink),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 44 px round icon button (back, read-aloud, mic).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.tint = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool tint;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: tint ? C.pl : Colors.white,
        shape: CircleBorder(side: tint ? BorderSide.none : const BorderSide(color: C.bd)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(icon, size: 22, color: tint ? C.p : C.ink, semanticLabel: label),
          ),
        ),
      ),
    );
  }
}
