import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/data/Services/onboarding_service.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void onPageChanged(int index) {
    emit(state.copyWith(currentPage: index));
  }

  bool isLastPage(int totalPages) {
    return state.currentPage == totalPages - 1;
  }

  // Called when the arrow button is tapped on the last page.
  Future<void> finishOnboarding() async {
    await OnboardingService.setOnboardingSeen();
    emit(state.copyWith(status: OnboardingStatus.completed));
  }
}