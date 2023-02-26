import 'package:flutter/cupertino.dart';
import 'package:rickandmorty/components/req_network_image.dart';
import 'package:rickandmorty/components/status_badge.dart';
import 'package:rickandmorty/views/character_details.dart';

import 'gender_icon.dart';

class CharactersCard extends StatelessWidget {
  final int characterId;
  final String imageUrl;
  final String name;
  final String status;
  final String species;
  final String gender;

  const CharactersCard({
    super.key,
    required this.characterId,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CharacterDetails.routeName,
          arguments: {
            'id': characterId,
            'name': name,
            'image': imageUrl,
            'status': status,
            'species': species,
            'gender': gender,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: CupertinoDynamicColor.resolve(
            CupertinoColors
                .tertiarySystemBackground, // Couleur de texte en mode sombre
            context,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .3),
              blurRadius: 10,
              offset: Offset(3, 5),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: ReqNetworkImage(
                imageUrl: imageUrl,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CupertinoDynamicColor.resolve(
                                  CupertinoColors
                                      .label, // Couleur de texte en mode sombre
                                  context,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        GenderIcon(gender: gender),
                        const SizedBox(width: 5),
                        GetStatusBadge(status: status),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            species,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 16,
                              color: CupertinoDynamicColor.resolve(
                                CupertinoColors
                                    .systemGrey, // Couleur de texte en mode sombre
                                context,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                color: CupertinoDynamicColor.resolve(
                  CupertinoColors
                      .tertiarySystemBackground, // Couleur de texte en mode sombre
                  context,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Icon(
                CupertinoIcons.right_chevron,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
