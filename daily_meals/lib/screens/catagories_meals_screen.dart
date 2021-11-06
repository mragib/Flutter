import 'package:flutter/material.dart';
import '/widgets/meal_item.dart';
import '../dummy-data.dart';
import '../models/meal.dart';

class CatagoryMealScreen extends StatefulWidget {
  // final String id;
  // final String catagoryTitle;

  // CatagoryMealScreen(this.id, this.catagoryTitle);
  final List<Meal> _availableMeals;
  CatagoryMealScreen(this._availableMeals);

  @override
  State<CatagoryMealScreen> createState() => _CatagoryMealScreenState();
}

class _CatagoryMealScreenState extends State<CatagoryMealScreen> {
  List<Meal> displayedMeals;
  String catagoryTitle;
  bool initLoad = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!initLoad) {
      final routerArg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      catagoryTitle = routerArg['title'];
      final catagoryID = routerArg['id'];
      displayedMeals = widget._availableMeals.where((meals) {
        return meals.categories.contains(catagoryID);
      }).toList();
      initLoad = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String id) {
    setState(() {
      displayedMeals.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catagoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].imageUrl,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
