// ignore_for_file: file_names

import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filter';
  final Function saveFilter;
  final Map<String, bool> currentFilter;
  const FiltersScreen(this.currentFilter, this.saveFilter);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten']!;
    _lactoseFree = widget.currentFilter['lactose']!;
    _vegan = widget.currentFilter['vegan']!;
    _vegetarian = widget.currentFilter['vegetarian']!;

    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subTitle, bool currentValue, var updatevalue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subTitle),
      activeColor: Theme.of(context).colorScheme.secondary,
      onChanged: updatevalue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          actions: [
            IconButton(
              onPressed: () {
                Map<String, bool> selectedData = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };

                widget.saveFilter(selectedData);
              },
              icon: const Icon(
                Icons.save,
              ),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Adjust Your Meal Selection!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchTile(
                  'Gluten-free',
                  'only include gluten-free meal',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose-free',
                  'only include lactose-free meal',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegetarian',
                  'only include vegetarian meal',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'only include vegan meal',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                )
              ],
            ))
          ],
        ));
  }
}
