import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetials extends StatelessWidget {
  const MealDetials({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Image.network(
        meal.imageUrl,
        width: double.infinity,
        // double.infinity makes sure that we are using whole available space
      ),
    );
  }
}
