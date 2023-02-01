import 'package:flutter/material.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, greatPlace, ch) => greatPlace.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlace.items[index].image!,
                            ),
                          ),
                          title: Text(
                            greatPlace.items[index].title,
                          ),
                          onTap: () {},
                        ),
                      ),
                child: const Center(
                  child: Text('Got no places yet. Start Adding some!'),
                ),
              ),
      ),
    );
  }
}
