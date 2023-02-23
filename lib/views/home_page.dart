import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rickandmorty/components/characters_card.dart';
import 'package:rickandmorty/components/search_bar.dart';
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
          // icon filter button
          trailing: GestureDetector(
              onTap: () {
                if (dotenv.get('FLUTTER_APP_DEBUG') == 'true') {
                  debugPrint('Filter button pressed');
                }
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => const FiltersModal(),
                );
              },
              child: const Icon(
                CupertinoIcons.slider_horizontal_3,
                color: CupertinoColors.systemBlue,
              ))),
      backgroundColor: CupertinoColors.secondarySystemBackground,
      // child: const SearchBar(),
      child: // search bar and below, the ListView of GetCharactersList
          Expanded(
        child: Column(
          children: <Widget>[
            // search bar
            SearchBar(onSubmitted: (String value) {
              if (dotenv.get('FLUTTER_APP_DEBUG') == 'true') {
                debugPrint('Search bar submitted: $value');
              }
            }),
            const Expanded(
              child: GetCharactersList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltersModal extends StatelessWidget {
  const FiltersModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Filter',
              style: TextStyle(
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.white, context))),
          CupertinoButton.filled(
              child: Text('Enregistrer',
                  style: TextStyle(
                      color: CupertinoDynamicColor.resolve(
                          CupertinoColors.white, context))),
              onPressed: () => {
                    if (dotenv.get('FLUTTER_APP_DEBUG') == 'true')
                      {debugPrint('Enregistrer button pressed')}
                  }),
        ],
      ),
    );
  }
}

class GetCharactersList extends StatelessWidget {
  const GetCharactersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        // PATCH : ajout des variables de recherche, pagination et filtres
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        );
      },
    );
  }
}
