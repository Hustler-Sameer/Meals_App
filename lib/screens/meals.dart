import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, required this.title});

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Ohh .... no meal available',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                )),
        const SizedBox(height: 16),
        Text(
          'No Meal Available',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    ));

    // if (meals.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: meals.length,
    //     itemBuilder: (ctx, index) {
    //       // now here we want to make sure that if single meal item is tapped then we can access it
    //       return MealItem(meal: meals[index]);
    //     },
    //   );
    // }

    // *** So the new updated function is here below ****

    void selectMeal(BuildContext context, Meal meal) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MealDetailsScreen(meal: meal),
        ),
      );
    }

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            meal: meals[index],
            onSelectMeal: (context, meal) {
              selectMeal(context, meal);
            },
          );
        },
      );
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content, // content being rendered conditionally
    );
  }
}
