import 'package:flutter/material.dart';
import '/widgets/meal_item.dart';
import '../dummy-data.dart';

class CatagoryMealScreen extends StatelessWidget {
  // final String id;
  // final String catagoryTitle;

  // CatagoryMealScreen(this.id, this.catagoryTitle);

  @override
  Widget build(BuildContext context) {
    final routerArg =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final catagoryTitle = routerArg['title'];
    final catagoryID = routerArg['id'];
    final filteredMeals = DUMMY_MEALS.where((meals) {
      return meals.categories.contains(catagoryID);
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(catagoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: filteredMeals[index].id,
              title: filteredMeals[index].title,
              affordability: filteredMeals[index].affordability,
              complexity: filteredMeals[index].complexity,
              duration: filteredMeals[index].duration,
              imageUrl: filteredMeals[index].imageUrl,
            );
          },
          itemCount: filteredMeals.length,
        ));
  }
}
