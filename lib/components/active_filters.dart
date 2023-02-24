import 'package:flutter/cupertino.dart';
import 'chip_toggle.dart';

class ActiveFilters extends StatelessWidget {
  final List<String> list;
  final Function(String)? onTap;

  const ActiveFilters({
    super.key,
    required this.list,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // row of active filters
    // map list to list of active filters and display them in ChipToggles
    // no need of Listview.builder, list is small (3 items max)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: <Widget>[
          for (var item in list)
            if (item.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                child: ChipToggle(
                  label: item,
                  selected: true,
                  onTap: () => onTap?.call(item),
                ),
              ),
        ],
      ),
    );
  }
}
