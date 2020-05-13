import 'package:bloc/bloc.dart';
import 'package:paratice/api/thecocktaildb/api_the_cocktail_db_repository.dart';
import 'package:paratice/api/themealdb/api_the_meal_db_repository.dart';
import 'package:paratice/model/randomcocktail/random_cocktail.dart';
import 'package:paratice/model/randommeal/random_meal.dart';

abstract class TheMealCocktailDbState {}

class TheMealCocktailDbInitial extends TheMealCocktailDbState {}

class TheMealCocktailDbLoading extends TheMealCocktailDbState {}

class TheMealCocktailDbFailure extends TheMealCocktailDbState {
  final String errorMessage;

  TheMealCocktailDbFailure(this.errorMessage);
}

class TheMealCocktailDbLoaded extends TheMealCocktailDbState {
  final RandomMeal randomMeal;
  final RandomCocktail randomCocktail;

  TheMealCocktailDbLoaded(this.randomMeal, this.randomCocktail);
}

class TheMealCocktailDbEvent {}

class TheMealCocktailDbBloc extends Bloc<TheMealCocktailDbEvent, TheMealCocktailDbState> {
  final ApiTheMealDbRepository _apiTheMealDbRepository = ApiTheMealDbRepository();
  final ApiTheCocktailDbRepository _apiTheCocktailDbRepository = ApiTheCocktailDbRepository();

  @override
  TheMealCocktailDbState get initialState => TheMealCocktailDbInitial();

  @override
  Stream<TheMealCocktailDbState> mapEventToState(TheMealCocktailDbEvent event) async* {
    yield TheMealCocktailDbLoading();
    RandomMeal randomMeal = await _apiTheMealDbRepository.fetchRandomMeal();
    if (randomMeal.error != null) {
      yield TheMealCocktailDbFailure(randomMeal.error);
      return;
    }
    RandomCocktail randomCocktail = await _apiTheCocktailDbRepository.fetchRandomCocktail();
    if (randomCocktail.error != null) {
      yield TheMealCocktailDbFailure(randomCocktail.error);
      return;
    }
    yield TheMealCocktailDbLoaded(randomMeal, randomCocktail);
  }

}