import 'package:flutter/cupertino.dart';

class GenderIcon extends StatelessWidget {
  const GenderIcon({
    super.key,
    required this.gender,
  });

  final String gender;

  @override
  Widget build(BuildContext context) {
    return gender == 'Male'
        ? const Icon(
            IconData(0xe3c5, fontFamily: 'MaterialIcons'),
            color: CupertinoColors.systemBlue,
          )
        : gender == 'Female'
            ? const Icon(
                IconData(0xe261, fontFamily: 'MaterialIcons'),
                color: CupertinoColors.systemPink,
              )
            : const Icon(
                IconData(0xe679, fontFamily: 'MaterialIcons'),
                color: CupertinoColors.systemPurple,
              );
  }
}
