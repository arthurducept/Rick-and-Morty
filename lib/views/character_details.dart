import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickandmorty/components/background_box.dart';
import 'package:rickandmorty/components/gender_icon.dart';
import 'package:rickandmorty/components/req_network_image.dart';
import 'package:rickandmorty/components/status_badge.dart';

import '../components/column_card.dart';

class CharacterDetails extends StatefulWidget {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  static const routeName = '/character-details';

  const CharacterDetails({
    super.key,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text(widget.name),
            // status badge on the right
            trailing: GetStatusBadge(status: widget.status)),
        child: Stack(
          children: [
            ReqNetworkImage(
                imageUrl: widget.image,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  color: CupertinoDynamicColor.resolve(
                          CupertinoColors.systemBackground, context)
                      .withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          // child: ReqNetworkImage(imageUrl: widget.image),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Query(
                        options: QueryOptions(
                            onError: (error) {
                              if (dotenv.get('FLUTTER_APP_DEBUG') == 'true') {
                                debugPrint(error.toString());
                              }
                            },
                            document: gql(r'''
                              query Character($id: ID!) {
                                character(id: $id) {
                                  id
                                  name
                                  image
                                  status
                                  species
                                  gender
                                  type
                                  location {
                                    name
                                    type
                                    dimension
                                  }
                                  origin {
                                    name
                                    type
                                    dimension
                                  }
                                  episode {
                                    episode
                                    name
                                  }
                                }
                              }
                            '''),
                            variables: {
                              'id': widget.id,
                            }),
                        builder: (result, {fetchMore, refetch}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }

                          if (result.isLoading) {
                            return const CupertinoActivityIndicator();
                          }

                          if (result.data!['character'] == null) {
                            return Center(
                              child: Text(
                                'Personnage introuvable',
                                style: TextStyle(
                                  color: CupertinoDynamicColor.resolve(
                                    CupertinoColors.label,
                                    context,
                                  ),
                                ),
                              ),
                            );
                          }
                          // PATCH : result data to CharacterDetailsModel
                          return Column(
                            children: [
                              BackgroundBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            result.data!['character']['name'],
                                            style: TextStyle(
                                              color:
                                                  CupertinoDynamicColor.resolve(
                                                CupertinoColors.label,
                                                context,
                                              ),
                                              fontSize: 24,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GenderIcon(
                                              gender: result.data!['character']
                                                  ['gender']),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // species
                                      Text(
                                        result.data!['character']['species'],
                                        style: TextStyle(
                                          color: CupertinoDynamicColor.resolve(
                                            CupertinoColors.secondaryLabel,
                                            context,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ColumnCard(title: 'Location', rows: [
                                [
                                  'Name: ',
                                  result.data!['character']['location']['name']
                                ],
                                [
                                  'Type: ',
                                  result.data!['character']['location']['type']
                                ],
                                [
                                  'Dimension: ',
                                  result.data!['character']['location']
                                      ['dimension']
                                ],
                              ]),
                              const SizedBox(height: 16),
                              ColumnCard(title: 'Origin', rows: [
                                [
                                  'Name: ',
                                  result.data!['character']['origin']['name']
                                ],
                                [
                                  'Type: ',
                                  result.data!['character']['origin']['type']
                                ],
                                [
                                  'Dimension: ',
                                  result.data!['character']['origin']
                                      ['dimension']
                                ],
                              ]),
                              const SizedBox(height: 16),
                              ColumnCard(
                                  title: 'Apparitions',
                                  rows: List<List<String>>.generate(
                                      result.data!['character']['episode']
                                          .length, (index) {
                                    return [
                                      '${result.data!['character']['episode'][index]['episode']}',
                                      result.data!['character']['episode']
                                          [index]['name']
                                    ];
                                  })),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
