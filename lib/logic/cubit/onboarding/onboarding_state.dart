enum OnboardingStatus { inProgress, completed }

class OnboardingState {
  final int currentPage;
  final OnboardingStatus status;

  const OnboardingState({
    this.currentPage = 0,
    this.status = OnboardingStatus.inProgress,
  });

  OnboardingState copyWith({
    int? currentPage,
    OnboardingStatus? status,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
    );
  }
}