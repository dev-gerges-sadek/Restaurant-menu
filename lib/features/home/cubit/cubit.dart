import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/firebase/firebase_db.dart';
import 'package:meal_app/core/firebase/model/meal_model.dart';
import 'package:meal_app/features/home/cubit/states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  final FireBaseDataSource fireBaseDataSource = FireBaseDataSource();
  List<MealModel> listOfData = [];
  List<MealModel> filteredMeals = [];

  void getData() async {
    emit(HomeLoadingState());

    try {
      // جلب البيانات من Firebase
      listOfData = await fireBaseDataSource.getData();

      // لو collection فارغة → أضف البيانات تلقائيًا
      if (listOfData.isEmpty) {
        await fireBaseDataSource.addData();
        listOfData = await fireBaseDataSource.getData();
      }

      // فلترة أولية على الفئة الافتراضية (Breakfast)
      filteredMeals = List.from(listOfData);
      emit(HomeSuccessState(mealData: filteredMeals));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }

  void filterByCategory(String category) {
    filteredMeals = listOfData
        .where((meal) => meal.mealType.toLowerCase() == category.toLowerCase())
        .toList();
    emit(HomeSuccessState(mealData: filteredMeals));
  }

  void toggleFavourite(MealModel meal) {
    meal.isFavourite = !meal.isFavourite;
    emit(HomeSuccessState(mealData: List.from(filteredMeals)));
  }
}