import 'package:flutter/material.dart';
import 'package:meal_app/core/theme/app_colors.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/onboarding/pages/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash.png", width: 200),
            const SizedBox(height: 15),
            const Text("Popular Recipes", style: AppTextStyles.sectionTitle),
          ],
        ),
      ),
    );
  }
}
