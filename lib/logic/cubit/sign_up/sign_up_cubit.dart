import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hansy/logic/repository/auth_repository.dart';
import 'sign_up_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignupCubit({
    required this.authRepository,
  }) : super(const SignUpState());

  void togglePasswordVisibility() {
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
    ));
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordConfirmation.isEmpty) {
      emit(state.copyWith(
        status: SignUpStatus.error,
        errorMessage: 'Please fill in all fields.',
      ));
      return;
    }

    if (password != passwordConfirmation) {
      emit(state.copyWith(
        status: SignUpStatus.error,
        errorMessage: 'Passwords do not match.',
      ));
      return;
    }

    emit(state.copyWith(
      status: SignUpStatus.loading,
      errorMessage: null,
    ));

    try {
      final result = await authRepository.signup(
        name: name,
        email: email,
        password: password,
        passwordconfirmation: passwordConfirmation,
      );

      print('Signup successful: $result');

      emit(state.copyWith(
        status: SignUpStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SignUpStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }
}