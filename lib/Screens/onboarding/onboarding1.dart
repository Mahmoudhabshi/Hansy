import 'package:flutter/material.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/onboarding/onboarding2.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(
                'assets/images/onboarding_1.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 12, left: 24, right: 24),
            //   child: Align(
            //     alignment: Alignment.centerLeft,
            //     child: Image.asset(
            //       'assets/images/hansy_logo.png',
            //       height: 28,
            //     ),
            //   ),
            // ),
            //
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         width: 342,
            //         child: Text(
            //           'Find your perfect\nDream home right now !',
            //           style: AppTextStyles.onboardingTitle,
            //         ),
            //       ),
            //       const SizedBox(height: 10),
            //       Text(
            //         'Our properties are masterpiece for every client with lasting value .',
            //         style: AppTextStyles.onboardingSubtitle,
            //       ),
            //     ],
            //   ),
            // ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        width: 24,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.accentBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.dotInactive,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreenTwo(),
                        ),
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: AppColors.accentBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}