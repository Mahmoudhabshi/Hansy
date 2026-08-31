import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/onboarding/auth_landing_screen.dart';
import 'package:hansy/logic/cubit/onboarding/onboarding_cubit.dart';
import 'package:hansy/logic/cubit/onboarding/onboarding_state.dart';
import 'package:hansy/Screens/HomeScreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const int _pageCount = 2;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_currentPage < _pageCount - 1) {
      _goToPage(_currentPage + 1);
    } else {
      context.read<OnboardingCubit>().finishOnboarding();
    }
  }

  void _previous() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthLandingScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardingBg,
        body: Column(
          children: [
            // Skip only makes sense after the first page (or always — your choice)
            if (_currentPage > 0)
              Padding(
                padding: const EdgeInsets.only(top: 60, right: 24),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (context) => const Homescreen(),)
                       );
                    } ,
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
              )
            else
              const SizedBox(height: 8), // keeps layout stable

            // Carousel
            Expanded(
              flex: 5,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  // Page 1
                  Image.asset(
                    'assets/images/onboarding_1.jpg',
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  // Page 2
                  Center(
                    child: Image.asset(
                      'assets/images/onboarding2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),

            // Title + subtitle (changes with page)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _currentPage == 1
                    ?
    //     Column(
                //   key: const ValueKey(0),
                //   crossAxisAlignment: CrossAxisAlignment.start, // or center if you prefer
                //   children: [
                //     // Uncomment / adjust if you still want the logo
                //     // Image.asset('assets/images/hansy_logo.png', height: 28),
                //     // const SizedBox(height: 12),
                //     SizedBox(
                //       width: 342,
                //       child: Text(
                //         'Find your perfect\nDream home right now !',
                //         style: AppTextStyles.onboardingTitle,
                //       ),
                //     ),
                //     const SizedBox(height: 10),
                //     Text(
                //       'Our properties are masterpiece for every client with lasting value .',
                //       style: AppTextStyles.onboardingSubtitle,
                //     ),
                //   ],
                // )
                //     :
                Column(
                  key: const ValueKey(1),
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
                ):Container(),
              ),
            ),

            const SizedBox(height: 20),

            // Bottom controls: back · dots · next
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back arrow (hidden / disabled on first page)
                  _currentPage > 0
                      ? GestureDetector(
                    onTap: _previous,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back, color: AppColors.textDark),
                    ),
                  )
                      : const SizedBox(width: 40), // keeps spacing

                  // Dots
                  Row(
                    children: List.generate(_pageCount, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.primaryRed : AppColors.dotInactive,
                            borderRadius: BorderRadius.circular(4), // works for both 8×8 circle and 24×8 pill
                          ));
                    }),
                  ),

                  // Forward arrow
                  GestureDetector(
                    onTap: _next,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: AppColors.primaryRed,
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