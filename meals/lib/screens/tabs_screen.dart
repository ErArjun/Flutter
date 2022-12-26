import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../models/meal.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabScreen(this.favoriteMeals);
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];
  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Meals'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorite'},
    ];
    super.initState();
  }

  int currentIndex = 0;
  void _selectPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[currentIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[currentIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
