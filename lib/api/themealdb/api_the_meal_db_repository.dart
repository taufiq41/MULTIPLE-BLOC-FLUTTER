import 'package:paratice/api/themealdb/api_the_meal_db_provider.dart';
import 'package:paratice/model/randommeal/random_meal.dart';

class ApiTheMealDbRepository {
  final ApiTheMealDbProvider _apiTheMealDbProvider = ApiTheMealDbProvider();

  Future<RandomMeal> fetchRandomMeal() => _apiTheMealDbProvider.getRandomMeal();
}