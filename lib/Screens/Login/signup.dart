import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/logic/repository/auth_repository.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/HomeScreen.dart';
import 'package:hansy/logic/cubit/sign_up/sign_up_cubit.dart';
import 'package:hansy/logic/cubit/sign_up/sign_up_state.dart';
import 'package:hansy/Screens/Login/user-verification_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        authRepository: context.read<AuthRepositoryImpl>(),
      ),
      child: const _SignUpView(),
    );
  }
}
class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void _onCreate(BuildContext context) {
    final password = _passwordController.text;
    final confirmPassword = _confirmpasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter and confirm your password.'),
        ),
      );
      return;
    }

    context.read<SignupCubit>().signup(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: password,
      passwordConfirmation: confirmPassword,
    );
  }

  void _onSignIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required Widget prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.placeholderGrey, fontSize: 14),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.accentBlue, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignUpState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          (current.status == SignUpStatus.error || current.status == SignUpStatus.success),
      listener: (context, state) {
        if (state.status == SignUpStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        } else if (state.status == SignUpStatus.success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                email: _emailController.text.trim(),
                authRepository: context.read<AuthRepositoryImpl>(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        final isLoading = state.status == SignUpStatus.loading;

        return Scaffold(
          backgroundColor: AppColors.white,
          // appBar: AppBar(
          //   backgroundColor: AppColors.white,
          //   elevation: 0,
          //   foregroundColor: AppColors.black,
          //   // title: const Text('Create an account'),
          // ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),

                  Image.asset(
                    'assets/images/hansy_logo.png',
                    height: 26,
                  ),

                  const SizedBox(height: 24),

                  Text('Create account', style: AppTextStyles.loginTitle),
                  const SizedBox(height: 6),
                  Text(
                    'Create an account to log in to explore about Hansy Real Estate',
                    style: AppTextStyles.loginSubtitle,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Name', style: AppTextStyles.fieldLabel),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: _fieldDecoration(
                      hint: 'Name',
                      prefixIcon: const Icon(Icons.person_outline, color: AppColors.placeholderGrey),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email', style: AppTextStyles.fieldLabel),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _fieldDecoration(
                      hint: 'Email',
                      prefixIcon: const Icon(Icons.mail_outline, color: AppColors.placeholderGrey),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Set Password', style: AppTextStyles.fieldLabel),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: state.obscurePassword,
                    decoration: _fieldDecoration(
                      hint: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.placeholderGrey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.placeholderGrey,
                        ),
                        onPressed: cubit.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox (height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Confirm Password', style: AppTextStyles.fieldLabel),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmpasswordController,
                    obscureText: state.obscurePassword,
                    decoration: _fieldDecoration(
                      hint: 'Confirm Password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.placeholderGrey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.placeholderGrey,
                        ),
                        onPressed: cubit.togglePasswordVisibility,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),


                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.submitRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {                cubit.signup(
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        passwordConfirmation: _confirmpasswordController.text.trim(),
                      ); },
                      child: isLoading
                          ?
                      const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.white,
                        ),
                      )
                          : Text('Create', style: AppTextStyles.buttonLabel),
                    ),
                  ),


                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                      ),
                      GestureDetector(
                        onTap: () => _onSignIn(context),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.submitRed,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}