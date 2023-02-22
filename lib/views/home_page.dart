import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickandmorty/components/characters_card.dart';
import 'package:rickandmorty/models/character.dart';

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
    String title = dotenv.get('FLUTTER_APP_TITLE'); // Mandatory
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      backgroundColor: CupertinoColors.secondarySystemBackground,
      child: GetCharactersList(),
    );
  }
}

class GetCharactersList extends StatelessWidget {
  const GetCharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(r'''
          query {
            characters(page: 1) {
              info {
                count,
                next,
                prev,
              }
              results {
                id,
                name,
                status,
                species,
                image,
                gender,
              }
            }
          }
        '''),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        List<CharacterModel> characters = result.data!['characters']['results']
            .map<CharacterModel>((json) => CharacterModel.fromJson(json))
            .toList();

        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return CharactersCard(
              characterId: characters[index].id,
              imageUrl: characters[index].image,
              name: characters[index].name,
              status: characters[index].status,
              gender: characters[index].gender,
              species: characters[index].species,
            );
          },
        );
      },
    );
  }
}
