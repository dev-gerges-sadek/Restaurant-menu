import 'package:meal_app/core/firebase/model/meal_model.dart';



sealed class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final List<MealModel> mealData;
  HomeSuccessState({required this.mealData});
}

class HomeLoadingState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String? message;
  HomeErrorState({this.message});
}
