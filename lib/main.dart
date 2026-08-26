import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/Screens/splash_screen.dart';
import 'package:hansy/logic/cubit/login/login_cubit.dart';
import 'package:hansy/logic/cubit/sign_up/sign_up_cubit.dart';
import 'package:hansy/logic/repository/auth_repository.dart';
import 'package:hansy/theme/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepositoryImpl>(
        create: (context) => AuthRepositoryImpl(),
      ),

    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(
              authRepository:  context.read<AuthRepositoryImpl>(),
          ),
        ),
        BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(authRepository: context.read<AuthRepository>(),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Hansy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
        ),
        home: const SplashScreen(),
      ),
    ),
    );
  }
}