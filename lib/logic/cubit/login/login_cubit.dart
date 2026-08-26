import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({
    required this.authRepository,
  }) : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
    ));
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(
      rememberMe: value,
    ));
  }

  Future<void> submit({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: 'Please enter both email and password.',
      ));
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.loading,
      errorMessage: null,
    ));

    try {
      final result = await authRepository.login(
        emailOrPhone: email,
        password: password,
      );

      // result is UserLoginResponseModel
      print('Login successful: $result');

      emit(state.copyWith(
        status: LoginStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}