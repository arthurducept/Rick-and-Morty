import 'package:flutter/cupertino.dart';
import 'package:rickandmorty/views/home_page.dart';
import 'package:rickandmorty/views/character_details.dart';
import 'package:rickandmorty/views/unknown_route_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Rick and Morty Fanbase',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
      ),
      initialRoute: HomePage.routeName,
      onGenerateRoute: _generateRoute,
      onGenerateInitialRoutes: _generateInitialRoutes,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    Map<String, dynamic> arguments = {};
    // print the route
    debugPrint("route: ${settings.name}");
    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }
    if (settings.name == null) {
      debugPrint("no route name");
      return CupertinoPageRoute(
        builder: (_) => UnknownRoutePage(route: settings),
        settings: settings,
      );
    }
    Iterable<String> routePath =
        settings.name!.split('/').where((path) => path != '');

    switch ('/${routePath.isEmpty ? '' : routePath.first}') {
      case HomePage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case CharacterDetails.routeName:
        return CupertinoPageRoute(
          builder: (_) =>
              CharacterDetails(characterId: arguments['characterId']),
          settings: settings,
        );
      default:
        return CupertinoPageRoute(
          builder: (_) => UnknownRoutePage(route: settings),
          settings: settings,
        );
    }
  }

  List<Route<dynamic>> _generateInitialRoutes(String path) {
    switch (path) {
      case HomePage.routeName:
        return [
          CupertinoPageRoute(builder: (_) => const HomePage()),
        ];
      default:
        return [
          CupertinoPageRoute(builder: (_) => const UnknownRoutePage()),
        ];
    }
  }
}
