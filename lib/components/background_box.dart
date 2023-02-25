import 'package:flutter/cupertino.dart';

class BackgroundBox extends StatelessWidget {
  final Widget child;

  const BackgroundBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.resolve(
          CupertinoColors.secondarySystemBackground,
          context,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
