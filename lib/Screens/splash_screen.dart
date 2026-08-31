import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/Screens/HomeScreen.dart';
import 'package:hansy/Screens/Login/changepassword.dart';
import 'package:hansy/Screens/Login/login.dart';
import 'package:hansy/logic/cubit/change_password/change_password_cubit.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/onboarding/onboarding1.dart';
import 'package:hansy/Screens/HomeScreen.dart';
import 'package:hansy/logic/cubit/splash/splash_cubit.dart';
import 'package:hansy/logic/cubit/splash/splash_state.dart';
import 'package:hansy/Screens/Login/user-verification_screen.dart';
import 'package:hansy/logic/repository/auth_repository.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkOnboardingStatus(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.goToOnboarding) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          } else if (state.status == SplashStatus.goToHome) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Image.asset(
              'assets/images/hansy_logo.png',
              width: 220,
            ),
          ),
        ),
      ),
    );
  }
}