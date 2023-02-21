// model of a character from api https://rickandmortyapi.com/graphql

class CharacterModel {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });
}

// class CharacterModel {
//   int id;
//   String name;
//   String status;
//   String species;
//   String gender;
//   String image;
//   String origin;

//   CharacterModel({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.species,
//     required this.gender,
//     required this.image,
//     required this.origin,
//   });
// }

class CharacterDetailsModel {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;
  String origin;

  CharacterDetailsModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
  });
}
