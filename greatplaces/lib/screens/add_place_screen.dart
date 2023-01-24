import 'package:flutter/material.dart';
import 'package:greatplaces/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _textController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ImageInput(),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _textController,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _textController,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _textController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            label: const Text('Add Place'),
          )
        ],
      ),
    );
  }
}
