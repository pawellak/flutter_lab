import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static String routeName = '/place-list';

  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext ctx) {
    return AppBar(
      title: const Text('Your Places'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(ctx).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add))
      ],
    );
  }

  Center buildBody(BuildContext context) => Center(
          child: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlaces.items[i].image,
                            ),
                          ),
                          title: Text(greatPlaces.items[i].title),
                          subtitle: Text(greatPlaces.items[i].location.address),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(PlaceDetailScreen.routeName,arguments: greatPlaces.items[i].id);
                          },
                        ),
                      ),
              ),
      ));
}
