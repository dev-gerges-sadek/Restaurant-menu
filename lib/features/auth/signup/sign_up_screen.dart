import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/theme/app_colors.dart';
import 'package:meal_app/core/theme/app_text_styles.dart';
import 'package:meal_app/features/auth/cubit/cubit.dart';
import 'package:meal_app/features/auth/cubit/states.dart';
import 'package:meal_app/features/auth/login/login_screen.dart';
import 'package:meal_app/features/auth/widgets/custome_form_text_field.dart';
import 'package:meal_app/features/auth/widgets/or_divider.dart';
import 'package:meal_app/features/home/widgets/custome_category_button.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if (state is SignUpSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Sign-Up successful'),
                      backgroundColor: Colors.green),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (state is SignUpErrorState) {
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Sign Up', style: AppTextStyles.h2),
                    const SizedBox(height: 24),
                    const Text('Name', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomeFormTextField(
                      controller: nameController,
                      hintText: 'Enter your name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Email', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomeFormTextField(
                      controller: emailController,
                      hintText: 'example@gmail.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) return 'Invalid email format';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Password', style: AppTextStyles.label),
                    const SizedBox(height: 8),
                    CustomeFormTextField(
                      controller: passwordController,
                      hintText: '********',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    state is SignUpLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : CustomeCategoryButton(
                            text: 'Save',
                            onTap: () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().signUp(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                    );
                              }
                            },
                            isSelected: true,
                          ),
                    const SizedBox(height: 24),
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
