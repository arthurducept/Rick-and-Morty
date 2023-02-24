import 'package:flutter/cupertino.dart';

// the toggle is a chip that can be selected or not
// it can be disabled but keep the same style
// it has a label and an icon (+ or -)
// when not selected, the icon is a plus, no color and border
// when selected, the icon is a minus, with a color and no border
class ChipToggle extends StatelessWidget {
  const ChipToggle({
    super.key,
    required this.label,
    this.selected = false,
    this.disabled = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final bool disabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected
              ? CupertinoDynamicColor.resolve(
                  CupertinoColors.systemBlue, context)
              : CupertinoDynamicColor.resolve(
                  CupertinoColors.systemGrey6, context),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: CupertinoDynamicColor.resolve(
                CupertinoColors.systemGrey4, context),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: selected
                    ? CupertinoColors.white
                    : CupertinoDynamicColor.resolve(
                        CupertinoColors.label, context),
              ),
            ),
            const SizedBox(width: 10),
            // CupertinoIcons - or + depending on the state
            Icon(
              selected ? CupertinoIcons.minus : CupertinoIcons.plus,
              color: selected
                  ? CupertinoColors.white
                  : CupertinoDynamicColor.resolve(
                      CupertinoColors.systemGrey4, context),
            ),
          ],
        ),
      ),
    );
  }
}
