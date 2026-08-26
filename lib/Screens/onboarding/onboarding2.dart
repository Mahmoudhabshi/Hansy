import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/onboarding/auth_landing_screen.dart';
import 'package:hansy/logic/cubit/onboarding/onboarding_cubit.dart';
import 'package:hansy/logic/cubit/onboarding/onboarding_state.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const _OnboardingScreenTwoView(),
    );
  }
}

class _OnboardingScreenTwoView extends StatelessWidget {
  const _OnboardingScreenTwoView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AuthLandingScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardingBg,
        body: SafeArea(
          child: Builder(
            builder: (context) {
              final cubit = context.read<OnboardingCubit>();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 24),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: cubit.finishOnboarding,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.skipGrey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Image.asset(
                        'assets/images/onboarding2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          'Find the Perfect Place to\nCall Home',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingTitle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Browse handpicked listings that match your dreams, needs, and budget .',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.onboardingSubtitle,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: AppColors.dotInactive,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryRed,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: cubit.finishOnboarding,
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_forward,
                              color: AppColors.primaryRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}