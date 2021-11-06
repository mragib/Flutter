import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '/screens/catagories_screen.dart';
import '/screens/favorite_screen.dart';
import '../models/meal.dart';

class TabpScreen extends StatefulWidget {
  final List<Meal> _favorite;

  TabpScreen(this._favorite);
  @override
  _TabpScreenState createState() => _TabpScreenState();
}

class _TabpScreenState extends State<TabpScreen> {
  List<Map<String, Object>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'page': CatagoriesScreen(),
        'title': 'Category',
      },
      {
        'page': FavoriteScreen(widget._favorite),
        'title': 'Your Favorite',
      },
    ];
  }

  int _selectedPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
