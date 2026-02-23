class UserModel {
  String name;

  String email;
  String password;
  List<dynamic> favoriteMeals;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.favoriteMeals, 
  });

  //to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'favoriteMeals': favoriteMeals,
    };
  }

  //from json
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      favoriteMeals: json['favoriteMeals'] ?? [], 
    );
  }
}
