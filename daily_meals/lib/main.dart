import 'package:flutter/material.dart';
import './dummy-data.dart';
import './screens/filters_screen.dart';
import './screens/tap_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/catagories_meals_screen.dart';
import './screens/catagories_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactog': false,
    'vegan': false,
    'vegeterian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilterMeals(Map<String, bool> _filterData) {
    setState(() {
      _filters = _filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactog'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegeterian'] && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavoriteMeal(String mealId) {
    final indexValue = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (indexValue >= 0) {
      setState(() {
        _favoriteMeals.removeAt(indexValue);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavoriteMeal(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabpScreen(_favoriteMeals),
        CatagoriesScreen.routeName: (ctx) =>
            CatagoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavoriteMeal, _isFavoriteMeal),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(_filters, _setFilterMeals),
      },
    );
  }
}
