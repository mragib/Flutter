import 'package:flutter/material.dart';
import './dummy-data.dart';

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
            return Text(filteredMeals[index].title);
          },
          itemCount: filteredMeals.length,
        ));
  }
}
