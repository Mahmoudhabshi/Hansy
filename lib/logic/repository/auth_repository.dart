import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hansy/data/models/user_login_response_model.dart';

/// Base URL for the API. Update to match your environment / constants file.
const String kBaseUrl = 'https://hansy-realestate.sddsand.org/api/v2';

/// Contract for authentication-related network calls.
abstract class AuthRepository {
  Future<UserLoginResponseModel> login({
    required String emailOrPhone,
    required String password,
  });

  Future<UserLoginResponseModel> signup({
    required name,
    required email,
    required password,
    required passwordconfirmation,
  });

  /// Verifies the OTP/token sent to the user's email.
  Future<UserLoginResponseModel> verifyOtp({
    required String email,
    required String otp,
  });

  /// Requests a new OTP be sent to [email].
  Future<void> resendOtp({required String email});

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl({Dio? dio})
      : _dio = dio ??
      Dio(
        BaseOptions(
          baseUrl: kBaseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          headers: {'Accept': 'application/json'},
        ),
      );

  @override
  Future<UserLoginResponseModel> login({
    required String emailOrPhone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/store-login',
        data: {
          'email': emailOrPhone,
          'password': password,
        },

      );

      final model = UserLoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );
      print(response.data);

      // await _persistSession(model);

      return model;
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      // Catches JSON parsing errors, type-cast failures, or anything
      // unexpected that isn't a DioException.
      throw Exception('Failed to process login response: $e');
    }
  }
  Future<UserLoginResponseModel> signup({
    required name,
    required email,
    required password,
    required passwordconfirmation,
  }) async {
    try{
      final response = await _dio.post('/store-register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordconfirmation,

        },options: Options(headers: {
          'Accept': 'application/json',
        },
        ),
      );
      print(response.data);
      return UserLoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

    }  on DioException catch(e) {
      throw _mapDioError(e);
    }catch(e){
      throw Exception('Failed to process signup response: $e');
    }
  }

  @override
  Future<UserLoginResponseModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dio.post(
        '/user-verification',
        data: {
          'email': email,
          'token': otp,
        },
        options: Options(headers: {
          'Accept': 'application/json',
        }),
      );

      print(response.data);

      final model = UserLoginResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      // await _persistSession(model);

      return model;
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw Exception('Failed to process verification response: $e');
    }
  }

  @override
  Future<void> resendOtp({required String email}) async {
    try {
      final response = await _dio.post(
        '/resend-register', // TODO: confirm this matches your "Resend Register" request path
        data: {'email': email},
        options: Options(headers: {
          'Accept': 'application/json',
        }),
      );
      print(response.data);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      throw Exception('Failed to resend code: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      await prefs.remove('user_id');
    } catch (e) {
      throw Exception('Failed to clear session: $e');
    }
  }

  // Future<void> _persistSession(UserLoginResponseModel model) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('access_token', model.accessToken);
  //     await prefs.setString('refresh_token', model.refreshToken);
  //     await prefs.setInt('user_id', model.user.id);
  //   } catch (e) {
  //     throw Exception('Failed to save session locally: $e');
  //   }
  // }

  Exception _mapDioError(DioException e) {
    if (e.response?.data is Map && (e.response?.data['message'] != null)) {
      return Exception(e.response?.data['message']);
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timed out. Please try again.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection.');
      default:
        return Exception('Something went wrong. Please try again.');
    }
  }
}