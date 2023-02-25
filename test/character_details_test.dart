import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:rickandmorty/views/character_details.dart';

void main() {
  testWidgets('test d\'intégration de la page de détails des personnages',
      (WidgetTester tester) async {
    final character = CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');
    await tester.pumpWidget(MaterialApp(
        home: CharacterDetails(
      id: character.id,
      name: character.name,
      status: character.status,
      gender: character.gender,
      image: character.image,
      species: character.species,
    )));
    expect(find.text('Character Details ${character.id} : ${character.name}'),
        findsOneWidget);
  });
}
