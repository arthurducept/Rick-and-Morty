import 'package:flutter/cupertino.dart';

class CharacterCard extends StatelessWidget {
  final int index;

  const CharacterCard({
    super.key,
    required this.index,
  });

  // The properties we will access are : id, name, status, image, species
  // each card will be a box with rounded corners, a shadow with opacity .5, and a row
  // The row will have an image on the left, and a column in the center and an arrow on the right
  // The image will have rounded corners on the top left and bottom left
  // The column will have the name, status and species

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        // color is white for light mode, black for dark mode
        color: CupertinoColors.tertiarySystemBackground,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .3),
            blurRadius: 4,
            offset: Offset(0, 5),
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
            child: Image.network(
              'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Rick Sanchez',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Alive',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Human',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 50,
            height: 100,
            decoration: const BoxDecoration(
              color: CupertinoColors.tertiarySystemBackground,
              borderRadius: BorderRadius.only(
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
    );
  }
}
