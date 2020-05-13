import 'package:paratice/api/thecocktaildb/api_the_cocktail_db_provider.dart';
import 'package:paratice/model/randomcocktail/random_cocktail.dart';

class ApiTheCocktailDbRepository {
  final ApiTheCocktailDbProvider _apiTheCocktailDbProvider = ApiTheCocktailDbProvider();

  Future<RandomCocktail> fetchRandomCocktail() => _apiTheCocktailDbProvider.getRandomCocktail();
}