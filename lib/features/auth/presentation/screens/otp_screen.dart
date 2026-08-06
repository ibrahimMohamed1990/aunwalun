// lib/features/auth/presentation/screens/otp_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _hasError = false;
  bool _isLoading = false;
  int _secondsRemaining = 59;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _resendOtp() {
    setState(() {
      _secondsRemaining = 59;
      _hasError = false;
      for (var c in _controllers) {
        c.clear();
      }
    });
    _focusNodes[0].requestFocus();
    _startTimer();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    if (_otp.length < 4) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Simulate wrong OTP for demo
    if (_otp != '1234') {
      setState(() {
        _hasError = true;
        _isLoading = false;
        for (var c in _controllers) {
          c.clear();
        }
      });
      _focusNodes[0].requestFocus();
      return;
    }

    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _onDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() => _hasError = false);

    if (_otp.length == 4) {
      _verify();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final phone = args?['phone'] ?? '50*******7';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Watermark
            Positioned(
              top: 80.h,
              left: 0,
              right: 0,
              child: Center(
                child: Opacity(
                  opacity: 0.06,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 280.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                // ── Error Banner ──
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _hasError ? 52.h : 0,
                  child: _hasError
                      ? Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F0),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: const Color(0xFFFFCDD2)),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() => _hasError = false),
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xFFE53935),
                                  size: 18,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  'عذراً, الكود الذي ادخلته غير صحيح',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    color: const Color(0xFFE53935),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              const Icon(
                                Icons.error_outline,
                                color: Color(0xFFE53935),
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),

                        // ── Title ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('≡', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 8.w),
                            Text(
                              'أدخل رمز التحقق',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1A2332),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            const Text('≡', style: TextStyle(fontSize: 20)),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        // ── Subtitle ──
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              color: Colors.grey.shade500,
                              height: 1.6,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'أرسلنا إليك رمزاً مكوّناً من أربعة أرقام على رقم جوالك\n',
                              ),
                              TextSpan(
                                text: phone,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13.sp,
                                  color: const Color(0xFF1A2332),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: ' ... يُرجى إدخاله هنا لإتمام العملية',
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.h),

                        // ── OTP Fields ──
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 64.w,
                              height: 64.h,
                              margin: EdgeInsets.symmetric(horizontal: 6.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: _hasError
                                      ? const Color(0xFFE53935)
                                      : _controllers[index].text.isNotEmpty
                                      ? const Color(0xFF2D6A4F)
                                      : Colors.grey.shade300,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  color: _hasError
                                      ? const Color(0xFFE53935)
                                      : const Color(0xFF1A2332),
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  counterText: '',
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (value) =>
                                    _onDigitChanged(value, index),
                              ),
                            );
                          }),
                        ),

                        const Spacer(),

                        // ── Confirm Button ──
                        SizedBox(
                          width: double.infinity,
                          height: 52.h,
                          child: ElevatedButton(
                            onPressed: _isLoading || _otp.length < 4
                                ? null
                                : _verify,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2D6A4F),
                              disabledBackgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'تأكيد',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // ── Timer & Resend ──
                        Column(
                          children: [
                            Text(
                              'هذا الرمز صالح لفترة محدودة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            _secondsRemaining > 0
                                ? Text(
                                    '(0:${_secondsRemaining.toString().padLeft(2, '0')})',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF2D6A4F),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: _resendOtp,
                                    child: Text(
                                      'إعادة إرسال الرمز',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF2D6A4F),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                          ],
                        ),

                        SizedBox(height: 24.h),

                        // Home indicator
                        Container(
                          width: 130.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),

                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
