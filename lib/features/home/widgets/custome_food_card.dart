import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/firebase/model/meal_model.dart';
import 'package:meal_app/features/home/cubit/cubit.dart';


class CustomeFoodCard extends StatelessWidget {
  final MealModel meal;

  const CustomeFoodCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       
        Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  meal.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(meal.name),
              ),
            ],
          ),
        ),

       
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              context.read<HomeCubit>().toggleFavourite(meal);
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                meal.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
