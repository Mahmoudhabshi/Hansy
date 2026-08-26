import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hansy/logic/repository/auth_repository.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/Login/login.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final AuthRepository authRepository;

  /// Called after successful verification. If null, the screen just
  /// pops itself with `true` as the result.
  final VoidCallback? onVerified;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    required this.authRepository,
    this.onVerified,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _otpLength = 6;
  static const int _resendCooldownSeconds = 60;

  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isVerifying = false;
  bool _isResending = false;
  String? _errorText;

  Timer? _resendTimer;
  int _secondsRemaining = _resendCooldownSeconds;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _secondsRemaining = _resendCooldownSeconds;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  Future<void> _handleVerify(String otp) async {
    if (otp.length != _otpLength) {
      setState(() {
        _errorText = 'Please enter the 6-digit code.';
      });
      return;
    }

    setState(() {
      _isVerifying = true;
      _errorText = null;
    });

    try {
      await widget.authRepository.verifyOtp(
        email: widget.email,
        otp: otp,
      );

      print('OTP entered: "$otp", length: ${otp.length}');

      if (!mounted) return;

      widget.onVerified?.call();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorText = e.toString().replaceFirst('Exception: ', '');
        _otpController.clear();
      });
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }


  Future<void> _handleResend() async {
    if (_secondsRemaining > 0 || _isResending) return;

    setState(() => _isResending = true);

    try {
      await widget.authRepository.resendOtp(email: widget.email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A new code has been sent to your email.')),
      );
      _startResendTimer();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                Image.asset(
                  'assets/images/hansy_logo.png',
                  height: 26,
                ),

                const SizedBox(height: 24),

                Text('Verify your email', style: AppTextStyles.loginTitle),
                const SizedBox(height: 6),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.loginSubtitle,
                    children: [
                      const TextSpan(text: 'We sent a 6-digit code to\n'),
                      TextSpan(
                        text: widget.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Verification code', style: AppTextStyles.fieldLabel),
                ),
                const SizedBox(height: 8),

                PinCodeTextField(
                  appContext: context,
                  length: _otpLength,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  autoFocus: true,
                  enablePinAutofill: true,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 52,
                    fieldWidth: 44,
                    borderWidth: 1,
                    activeColor: AppColors.accentBlue,
                    selectedColor: AppColors.accentBlue,
                    inactiveColor: AppColors.inputBorder,
                    activeFillColor: AppColors.white,
                    selectedFillColor: AppColors.white,
                    inactiveFillColor: AppColors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 200),
                  onCompleted: _handleVerify,
                  onChanged: (value) {
                    if (_errorText != null) {
                      setState(() => _errorText = null);
                    }
                  },
                ),

                if (_errorText != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isVerifying
                        ? null
                        : () => _handleVerify(_otpController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.submitRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isVerifying
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.white,
                      ),
                    )
                        : Text('Verify', style: AppTextStyles.buttonLabel),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _secondsRemaining > 0
                          ? "Didn't get the code? "
                          : "Didn't get the code? ",
                      style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                    ),
                    if (_secondsRemaining > 0)
                      Text(
                        'Resend in ${_secondsRemaining}s',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textGrey,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: _isResending ? null : _handleResend,
                        child: _isResending
                            ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.submitRed,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}