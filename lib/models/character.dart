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

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: int.parse(json['id']),
      name: json['name'],
      status: json['status'],
      species: json['species'],
      image: json['image'],
      gender: json['gender'],
    );
  }
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
