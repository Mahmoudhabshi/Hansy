import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/logic/cubit/change_password/change_password_cubit.dart';
import 'package:hansy/logic/cubit/change_password/change_password_state.dart';
import 'package:hansy/Screens/Login/signup.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    context.read<ChangePasswordCubit>().submit(
      email: _emailController.text.trim(),
    );
  }

  // void _onContinueWithGoogle() {
  // }
  //
  // void _onContinueWithFacebook() {
  // }

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
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (previous, current) =>
      previous.status != current.status &&
          (current.status == ChangePasswordStatus.error ||
              current.status == ChangePasswordStatus.success),
      listener: (context, state) {
        if (state.status == ChangePasswordStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        } else if (state.status == ChangePasswordStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset link sent. Check your email.')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == ChangePasswordStatus.loading;

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            foregroundColor: AppColors.black,
            title: const Text('Log in'),
            centerTitle: false,
          ),
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

                  Text('Change Password', style: AppTextStyles.loginTitle),
                  const SizedBox(height: 6),
                  Text(
                    'Enter your email and we will send you a link to reset your password.',
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

                  const SizedBox(height: 28),

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
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.white,
                        ),
                      )
                          : Text('Submit', style: AppTextStyles.buttonLabel),
                    ),
                  ),

                  const SizedBox(height: 24),

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


                  // _SocialButton(
                  //   label: 'Continue with Google',
                  //   icon: const Icon(Icons.g_mobiledata_rounded, color: Color(0xFF1877F2), size: 22),
                  //   onTap: _onContinueWithGoogle,
                  // ),
                  //
                  // const SizedBox(height: 14),
                  //
                  // _SocialButton(
                  //   label: 'Continue with Facebook',
                  //   icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 22),
                  //   onTap: _onContinueWithFacebook,
                  // ),

                  const SizedBox(height: 40),


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