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

class CharacterDetailsModel {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;
  String origin;
  String location;

  CharacterDetailsModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  factory CharacterDetailsModel.fromJson(Map<String, dynamic> json) {
    return CharacterDetailsModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        gender: json['gender'],
        image: json['image'],
        origin: json['origin'].name,
        location: json['location'].name);
  }
}
