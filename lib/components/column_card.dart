import 'package:flutter/cupertino.dart';

import 'background_box.dart';

class ColumnCard extends StatelessWidget {
  final String title;
  final List<List<String>> rows;

  const ColumnCard({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: CupertinoDynamicColor.resolve(
                CupertinoColors.label,
                context,
              ),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // rows (label, value) and sized box below
          ...rows.map((row) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        row[0],
                        style: TextStyle(
                          color: CupertinoDynamicColor.resolve(
                            CupertinoColors.label,
                            context,
                          ),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          row[1],
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: CupertinoDynamicColor.resolve(
                              CupertinoColors.secondaryLabel,
                              context,
                            ),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              )),
        ],
      ),
    ));
  }
}
