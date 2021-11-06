import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  FavoriteScreen(this._favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorite meal. Please Add some"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favoriteMeals[index].id,
            title: _favoriteMeals[index].title,
            affordability: _favoriteMeals[index].affordability,
            complexity: _favoriteMeals[index].complexity,
            duration: _favoriteMeals[index].duration,
            imageUrl: _favoriteMeals[index].imageUrl,
          );
        },
        itemCount: _favoriteMeals.length,
      );
    }
  }
}
