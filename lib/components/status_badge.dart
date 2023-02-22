import 'package:flutter/cupertino.dart';

class GetStatusBadge extends StatelessWidget {
  const GetStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: status == 'Alive'
            ? CupertinoColors.activeGreen
            : status == 'Dead'
                ? CupertinoColors.destructiveRed
                : CupertinoColors.systemYellow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: const TextStyle(
          fontSize: 16,
          color: CupertinoColors.label,
        ),
      ),
    );
  }
}
