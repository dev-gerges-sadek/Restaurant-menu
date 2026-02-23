class MealModel {
  final String name;
  final String image;
  final String description;
  final String mealType;
  final int calories;
  bool isFavourite; 

  MealModel({
    required this.name,
    required this.image,
    required this.description,
    required this.mealType,
    required this.calories,
    this.isFavourite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "description": description,
      "mealType": mealType,
      "calories": calories,
      "isFavourite": isFavourite,
    };
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      mealType: json['mealType'],
      calories: json['calories'],
      isFavourite: json['isFavourite'] ?? false,
    );
  }
}
