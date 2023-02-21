import 'package:flutter/cupertino.dart';
import 'package:rickandmorty/components/characters_card.dart';
import 'package:rickandmorty/models/character.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CharacterModel> characters = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Rick and Morty Fanbase'),
      ),
      backgroundColor: CupertinoColors.systemBackground,
      child: ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return CharacterCard(index: index);
        },
      ),
    );
  }
}
