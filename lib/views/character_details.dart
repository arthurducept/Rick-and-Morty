import 'package:flutter/cupertino.dart';
import 'package:rickandmorty/models/character.dart';

class CharacterDetails extends StatelessWidget {
  final int characterId;

  static const routeName = '/character-details';

  const CharacterDetails({super.key, required this.characterId});

  // for the moment, get the api data here : https://rickandmortyapi.com/api/character/1
  // then, create a CharacterDetailsModel from the json response

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Character Details'),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Character Details $characterId',
                    style: TextStyle(
                      color: CupertinoDynamicColor.resolve(
                        CupertinoColors
                            .label, // Couleur de texte en mode sombre
                        context,
                      ),
                    )),
              ]),
        ));
  }
}
















  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //       navigationBar: CupertinoNavigationBar(
  //         middle: Text(character.name),
  //       ),
  //       child: Center(
  //         child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Image.network(character.image),
  //               Text(character.status),
  //               Text(character.species),
  //               Text(character.gender)
  //             ]),
  //       ));
  // }