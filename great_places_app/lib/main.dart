import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(),
      child: MaterialApp(
        title: 'Great Places',
        home: const PlacesListScreen(),
        routes: buildRoutes(),
        theme: buildThemeData(),
      ),
    );
  }

  List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider(
        create: (context) => GreatPlaces(),
      )
    ];
  }

  Map<String, WidgetBuilder> buildRoutes() => {
        AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
        PlacesListScreen.routeName: (context) => const PlacesListScreen(),
        PlaceDetailScreen.routeName: (ctx) =>const PlaceDetailScreen(),
      };

  ThemeData buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
          .copyWith(secondary: Colors.amber),
    );
  }
}
