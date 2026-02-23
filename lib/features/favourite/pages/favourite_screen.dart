import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/home/cubit/cubit.dart';
import 'package:meal_app/features/home/cubit/states.dart';
import 'package:meal_app/features/home/widgets/custome_food_card.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: Column(
          children: [
            const Row(
              children: [
                Text("My Favourites", style: AppTextStyles.sectionTitle),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is HomeSuccessState) {
                  final favourites =
                      state.mealData.where((meal) => meal.isFavourite).toList();

                  if (favourites.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text("No favourite meals yet ❤️"),
                      ),
                    );
                  }

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: favourites.length,
                      itemBuilder: (context, index) {
                        return CustomeFoodCard(
                          meal: favourites[index], 
                        );
                      },
                    ),
                  );
                }

                return const Expanded(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
