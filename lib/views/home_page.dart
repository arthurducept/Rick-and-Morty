import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rickandmorty/components/characters_card.dart';
import 'package:rickandmorty/components/search_bar.dart';
import 'package:rickandmorty/models/character.dart';

import '../components/active_filters.dart';
import '../components/filters_modal.dart';

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

  String _selectedStatus = "";
  String _selectedGender = "";
  String _selectedSpecies = "";
  String _searchQuery = "";
  int page = 1; // PATCH: pagination

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
                  builder: (context) => FiltersModal(
                    selectedStatus: _selectedStatus,
                    selectedGender: _selectedGender,
                    selectedSpecies: _selectedSpecies,
                    onSaved: (selectedStatus, selectedGender, selectedSpecies) {
                      setState(() {
                        _selectedStatus = selectedStatus;
                        _selectedGender = selectedGender;
                        _selectedSpecies = selectedSpecies;
                      });
                    },
                  ),
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
              setState(() {
                _searchQuery = value;
              });
            }),
            // list of active filters
            ActiveFilters(
                list: [
                  _selectedStatus,
                  _selectedGender,
                  _selectedSpecies,
                ],
                onTap: (String value) {
                  if (dotenv.get('FLUTTER_APP_DEBUG') == 'true') {
                    debugPrint('Active filter removed: $value');
                  }
                  setState(() {
                    if (_selectedStatus == value) {
                      _selectedStatus = "";
                    }
                    if (_selectedGender == value) {
                      _selectedGender = "";
                    }
                    if (_selectedSpecies == value) {
                      _selectedSpecies = "";
                    }
                  });
                }),

            Expanded(
              child: Query(
                options: QueryOptions(
                  // PATCH : ajout des variables de recherche, pagination et filtres
                  // result needs id, name, status, species, image, gender,
                  // info needs count, next, prev
                  // variables: page, filter (name, status, species, gender)
                  document: gql(r'''
                    query GetCharactersList($page: Int!, $searchQuery: String, $status: String, $gender: String, $species: String) {
                      characters(page: $page, filter: { name: $searchQuery, status: $status, gender: $gender, species: $species }) {
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
                  variables: <String, dynamic>{
                    'page': 1,
                    'searchQuery':
                        _searchQuery.isNotEmpty ? _searchQuery : null,
                    'status': _selectedStatus.isNotEmpty
                        ? getFilterSlug(title: "Statut", label: _selectedStatus)
                        : null,
                    'gender': _selectedGender.isNotEmpty
                        ? getFilterSlug(title: "Genre", label: _selectedGender)
                        : null,
                    'species': _selectedSpecies.isNotEmpty
                        ? getFilterSlug(
                            title: "Espèce", label: _selectedSpecies)
                        : null,
                  },
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  // if no result.data!['results']
                  if (result.data!['characters']['results'].length == 0) {
                    return Center(
                      child: Text(
                        'Aucun résultat',
                        style: TextStyle(
                          color: CupertinoDynamicColor.resolve(
                            CupertinoColors.secondaryLabel,
                            context,
                          ),
                        ),
                      ),
                    );
                  }

                  List<CharacterModel> characters = result.data!['characters']
                          ['results']
                      .map<CharacterModel>(
                          (json) => CharacterModel.fromJson(json))
                      .toList();

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
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
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFilterSlug({required String title, required String label}) {
    switch (title) {
      case "Statut":
        switch (label) {
          case "Vivant":
            return "alive";
          case "Mort":
            return "dead";
          case "Inconnu":
            return "unknown";
          default:
        }
        break;
      case "Genre":
        switch (label) {
          case "Homme":
            return "Male";
          case "Femme":
            return "Female";
          case "Sans genre":
            return "Genderless";
          case "Inconnu":
            return "unknown";
          default:
        }
        break;
      case "Espèce":
        switch (label) {
          case "Humain":
            return "human";
          case "Alien":
            return "Alien";
          default:
        }
        break;

      default:
    }
  }
}
