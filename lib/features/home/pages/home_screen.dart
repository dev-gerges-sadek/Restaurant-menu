import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/theme/app_colors.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/favourite/pages/favourite_screen.dart';
import 'package:meal_app/features/home/cubit/cubit.dart';
import 'package:meal_app/features/home/cubit/states.dart';
import 'package:meal_app/features/home/widgets/custome_category_button.dart';
import 'package:meal_app/features/home/widgets/custome_food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = const ['Breakfast', 'Lunch', 'Dinner'];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeCubit>();
    cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.wb_sunny_outlined,
                  size: 35,
                  color: AppColors.accent,
                ),
                Text(
                  " Good Morning",
                  style: TextStyle(
                    color: AppColors.bodyText,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text("Category", style: AppTextStyles.sectionTitle),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return CustomeCategoryButton(
                    text: categories[index],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() => selectedIndex = index);
                      context.read<HomeCubit>().filterByCategory(
                        categories[index],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  if (state is HomeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is HomeSuccessState) {
                    final filtered = context.read<HomeCubit>().filteredMeals;
                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text("No meals found in this category"),
                      );
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 4,
                          ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return CustomeFoodCard(meal: filtered[index]);
                      },
                    );
                  }
                  if (state is HomeErrorState) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
