enum LoginStatus { initial, loading, success, error }

class LoginState {
  final bool obscurePassword;
  final bool rememberMe;
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    this.obscurePassword = true,
    this.rememberMe = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? rememberMe,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}