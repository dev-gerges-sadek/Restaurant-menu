import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/auth/cubit/cubit.dart';
import 'package:meal_app/features/home/cubit/cubit.dart';
import 'package:meal_app/features/splash/pages/splash_screen.dart';
import 'package:meal_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit()),
          BlocProvider(create: (_) => HomeCubit()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
