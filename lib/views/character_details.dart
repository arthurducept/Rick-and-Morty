import 'package:flutter/cupertino.dart';
import 'package:rickandmorty/components/gender_icon.dart';
import 'package:rickandmorty/components/status_badge.dart';
import 'package:rickandmorty/models/character.dart';

class CharacterDetails extends StatelessWidget {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  static const routeName = '/character-details';

  const CharacterDetails({
    super.key,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  // for the moment, get the api data here : https://rickandmortyapi.com/api/character/1
  // then, create a CharacterDetailsModel from the json response

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text(name),
            // status badge on the right
            trailing: GetStatusBadge(status: status)),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(image),
                Text('Character Details $id : $name',
                    style: TextStyle(
                      color: CupertinoDynamicColor.resolve(
                        CupertinoColors
                            .label, // Couleur de texte en mode sombre
                        context,
                      ),
                    )),
                Text(species,
                    style: TextStyle(
                      color: CupertinoDynamicColor.resolve(
                        CupertinoColors
                            .label, // Couleur de texte en mode sombre
                        context,
                      ),
                    )),
                GenderIcon(gender: gender)
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