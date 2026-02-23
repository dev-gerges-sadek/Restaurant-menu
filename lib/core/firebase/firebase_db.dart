// Karim Toson || kareemtoson1@gmail.com || Sat Feb 07 2026 17:51:11

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_app/core/firebase/model/meal_model.dart';
import 'package:meal_app/features/auth/models/user_model.dart';


class FireBaseDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //sign up
  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
            UserModel(
              email: email,
              name: name,
              password: password,
              favoriteMeals: [],
            ).toJson(),
          );
    } catch (e) {
      rethrow;
    }
  }

  //login
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  ///
  Future<void> addData() async {
    final List<MealModel> mealsData = [
      // 🥣 Breakfast meals
      MealModel(
        name: 'Avocado Toast with Eggs',
        calories: 350,
        image:
            'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=800',
        description: 'Whole grain toast with mashed avocado and poached eggs',
        mealType: 'Breakfast',
      ),
      MealModel(
        name: 'Greek Yogurt Parfait',
        calories: 280,
        image:
            'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=800',
        description: 'Greek yogurt layered with fresh berries and granola',
        mealType: 'Breakfast',
      ),
      MealModel(
        name: 'Oatmeal Bowl',
        calories: 320,
        image:
            'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=800',
        description: 'Oatmeal topped with banana, nuts and honey',
        mealType: 'Breakfast',
      ),
      // 🍛 Lunch meals
      MealModel(
        name: 'Grilled Chicken Salad',
        calories: 420,
        image:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
        description: 'Fresh mixed greens with grilled chicken breast',
        mealType: 'Lunch',
      ),
      MealModel(
        name: 'Quinoa Buddha Bowl',
        calories: 480,
        image:
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
        description: 'Quinoa with roasted vegetables and chickpeas',
        mealType: 'Lunch',
      ),
      MealModel(
        name: 'Turkey Wrap',
        calories: 390,
        image:
            'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=800',
        description: 'Whole wheat wrap with turkey, lettuce and tomato',
        mealType: 'Lunch',
      ),
      // 🍽️ Dinner meals
      MealModel(
        name: 'Grilled Salmon with Vegetables',
        calories: 520,
        image:
            'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800',
        description: 'Fresh grilled salmon with steamed broccoli and carrots',
        mealType: 'Dinner',
      ),
      MealModel(
        name: 'Chicken Stir Fry',
        calories: 460,
        image:
            'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800',
        description: 'Chicken with mixed vegetables in Asian sauce',
        mealType: 'Dinner',
      ),
      MealModel(
        name: 'Grilled Steak',
        calories: 580,
        image:
            'https://images.unsplash.com/photo-1558030006-450675393462?w=800',
        description: 'Tender grilled steak with garlic mashed potatoes',
        mealType: 'Dinner',
      ),
    ];

    for (MealModel item in mealsData) {
      await _firebaseFirestore.collection('meals').add(item.toJson());
    }
  }

  //get data
  Future<List<MealModel>> getData() async {
    List<MealModel> mealData = [];
    try {
      QuerySnapshot jsonData =
          await _firebaseFirestore.collection('meals').get();
      for (var item in jsonData.docs) {
        mealData.add(MealModel.fromJson(item.data() as Map<String, dynamic>));
      }

      return mealData;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
