import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/data/Services/onboarding_service.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> checkOnboardingStatus() async {
    // Show splash for a few seconds
    await Future.delayed(const Duration(seconds: 3));

    final hasSeenOnboarding = await OnboardingService.hasSeenOnboarding();

    emit(state.copyWith(
      status: hasSeenOnboarding ? SplashStatus.goToHome : SplashStatus.goToOnboarding,
    ));
  }
}