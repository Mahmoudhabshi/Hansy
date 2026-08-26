enum SplashStatus { loading, goToOnboarding, goToHome }

class SplashState {
  final SplashStatus status;

  const SplashState({this.status = SplashStatus.loading});

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}