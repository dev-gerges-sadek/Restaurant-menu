import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/theme/app_colors.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/auth/cubit/cubit.dart';
import 'package:meal_app/features/auth/cubit/states.dart';
import 'package:meal_app/features/auth/signup/sign_up_screen.dart';
import 'package:meal_app/features/auth/widgets/custome_form_text_field.dart';
import 'package:meal_app/features/auth/widgets/or_divider.dart';
import 'package:meal_app/features/home/pages/home_screen.dart';
import 'package:meal_app/features/home/widgets/custome_category_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Welcome Back!'),
                      backgroundColor: Colors.green),
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false);
              } else if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.error), backgroundColor: Colors.red),
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text('Login', style: AppTextStyles.h2),
                    const SizedBox(height: 8),
                    const SizedBox(height: 32),
                    const Text('Email', style: AppTextStyles.label),
                    const SizedBox(height: 10),
                    CustomeFormTextField(
                      controller: emailController,
                      hintText: 'example@gmail.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Password', style: AppTextStyles.label),
                    const SizedBox(height: 10),
                    CustomeFormTextField(
                      controller: passwordController,
                      hintText: '********',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be 8+ characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: AppTextStyles.muted
                              .copyWith(fontSize: 16, color: AppColors.accent),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignUpScreen())),
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.muted.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    state is LoginLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: CustomeCategoryButton(
                              text: 'Login',
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  context.read<AuthCubit>().login(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              isSelected: true,
                            ),
                          ),
                    const SizedBox(height: 30),
                    const OrDivider(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
