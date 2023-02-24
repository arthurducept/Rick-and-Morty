import 'package:flutter/cupertino.dart';
import 'chip_toggle.dart';

class ChipList extends StatelessWidget {
  final String title;
  final List<String> labels;
  final String selected;
  final Function(String)? onTap;

  const ChipList({
    super.key,
    required this.title,
    required this.labels,
    this.selected = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.label, context),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          // status chips ChipToggle(label)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: labels
                .map(
                  (label) => ChipToggle(
                    label: label,
                    onTap: () => onTap?.call(label),
                    selected: label == selected,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
