// lib/features/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:meal_app/core/theme/app_colors.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/auth/login/login_screen.dart';
import 'package:meal_app/features/home/widgets/custome_category_button.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/onboarding.png"),
              const SizedBox(height: 45),
              const Text(
                "Help your path to health\ngoals with happiness",
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: CustomeCategoryButton(
                  text: 'Start',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  isSelected: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
