import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/Screens/Login/changepassword.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/HomeScreen.dart';
import 'package:hansy/Screens/Login/signup.dart';
import 'package:hansy/logic/cubit/login/login_cubit.dart';
import 'package:hansy/logic/cubit/login/login_state.dart';
import 'package:hansy/Screens/Login/user-verification_screen.dart';
import 'package:hansy/logic/repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginView();
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    context.read<LoginCubit>().submit(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  void _onContinueWithGoogle() {
  }

  void _onContinueWithFacebook() {
  }

  void _onForgotPassword() {
  }

  void _onSignUp(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
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
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          (current.status == LoginStatus.error || current.status == LoginStatus.success),
      listener: (context, state) {
        if (state.status == LoginStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        } else if (state.status == LoginStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Homescreen()
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        final isLoading = state.status == LoginStatus.loading;

        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),

                  Image.asset(
                    'assets/images/hansy_logo.png',
                    height: 26,
                  ),

                  const SizedBox(height: 24),

                  Text('Get Started now', style: AppTextStyles.loginTitle),
                  const SizedBox(height: 6),
                  Text(
                    'Please log in to explore about Hansy Real Estate',
                    style: AppTextStyles.loginSubtitle,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

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
                    child: Text('Password', style: AppTextStyles.fieldLabel),
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

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onSubmit(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.submitRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? InkWell(
                        onTap:()=> cubit.submit(email: _emailController.text, password: _passwordController.text),
                        child: const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.white,
                          ),
                        ),
                      )
                          : Text('Submit', style: AppTextStyles.buttonLabel),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: state.rememberMe,
                              onChanged: (value) => cubit.toggleRememberMe(value ?? false),
                              activeColor: AppColors.accentBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me',
                            style: TextStyle(fontSize: 13, color: AppColors.textDark),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ChangePasswordScreen(),)
                          );
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.inputBorder)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('Or', style: TextStyle(color: AppColors.textGrey)),
                      ),
                      Expanded(child: Divider(color: AppColors.inputBorder)),
                    ],
                  ),

                  const SizedBox(height: 20),


                  _SocialButton(
                    label: 'Continue with Google',
                    icon: const Icon(Icons.g_mobiledata_rounded, color: Color(0xFF1877F2), size: 22),
                    onTap: _onContinueWithGoogle,
                  ),

                  const SizedBox(height: 14),

                  _SocialButton(
                    label: 'Continue with Facebook',
                    icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 22),
                    onTap: _onContinueWithFacebook,
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                      ),
                      GestureDetector(
                        onTap: () => _onSignUp(context),
                        child: Text(
                          'Sign Up',
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

class _SocialButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.inputBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}