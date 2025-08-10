import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilteres(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool value) {
    state = {...state, filter: value};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree] == true && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree] == true && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian] == true && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan] == true && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
