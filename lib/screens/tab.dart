import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFIlters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
  // we have set the initial values to be false and they will be changed once the filters are applied and then pressed back
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreen();
  }
}

class _TabScreen extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];

  Map<Filter, bool> _selectedFilters = kInitialFIlters;

  void _selectPage(int index) {
    setState(() {
      // here the index will be 1 already on click
      _selectedPageIndex = index;
      print(_selectedPageIndex);
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage("Item Removed from Favourites");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage('Item added to Favourites');
      });
    }
  }

  void _setScreen(String identifer) async {
    Navigator.of(context).pop(); // this will close the drawer
    if (identifer == 'filters') {
      final result = await Navigator.of(context).push<
          Map<Filter,
              bool>>(MaterialPageRoute(
          builder: ((ctx) =>
              FilterScreen()))); // .push is told that it will get a map which has filter enum with boolean as key in it
      print(result);
      setState(() {
        _selectedFilters = result ?? kInitialFIlters;
        // hence if user does not select any filter and returns back the fallback values will be intial values set
      });
    } else {
      // now we are already in the meals page hence we just need to close the drawer and go back to meals page
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _availableMeals = dummyMeals.where(
      (meal) {
        if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          // _selectedFilters[Filter.glutenFree]  this checks if glutenFree filter is set and after
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: _availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = ' Your Favourite Meals';
    }
    // this code has one problem i.e 2 appbars will be visible  1st fo tab page and 2nd will be of the page we are displaying
    // now we are removing app bar in categories screen
    // also in the meals screen we have made our title of appbar conditional

    // ****** now sending filtered meals to display

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex:
            _selectedPageIndex, // this will let us highlight the tab selected in nav bar
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourites'),
        ],
      ),
    );
  }
}
