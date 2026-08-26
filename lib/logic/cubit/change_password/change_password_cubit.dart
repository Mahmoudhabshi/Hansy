import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'change_password_state.dart';
import 'package:hansy/logic/repository/auth_repository.dart';

// const String kBaseUrl = 'https://hansy-realestate.sddsand.org/api/v2';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> submit({required String email}) async {
    if (email.isEmpty) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMessage: 'Please enter your email.',
      ));
      return;
    }

    if (!_isValidEmail(email)) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMessage: 'Please enter a valid email address.',
      ));
      return;
    }

    emit(state.copyWith(status: ChangePasswordStatus.loading, errorMessage: null));

    try {
      final uri = Uri.parse('$kBaseUrl/send-forget-password');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        emit(state.copyWith(status: ChangePasswordStatus.success, errorMessage: null));
      } else {
        final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};
        final message = decoded is Map<String, dynamic>
            ? (decoded['message'] ?? decoded['error'] ?? 'Something went wrong')
            : 'Something went wrong';

        emit(state.copyWith(
          status: ChangePasswordStatus.error,
          errorMessage: message.toString(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ChangePasswordStatus.error,
        errorMessage: 'Network error. Please try again.',
      ));
    }
  }
}