enum SignUpStatus { initial, loading, success, error }

class SignUpState {
  final bool obscurePassword;
  final SignUpStatus status;
  final String? errorMessage;

  static var error;

  static var loading;

  static var success;

  const SignUpState({
    this.obscurePassword = true,
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? obscurePassword,
    SignUpStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}