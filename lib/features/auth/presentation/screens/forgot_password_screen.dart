// lib/features/auth/presentation/screens/forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedCountryCode = '+966';
  String _selectedFlag = '🇸🇦';

  final List<Map<String, String>> _countries = [
    {'code': '+966', 'flag': '🇸🇦', 'name': 'السعودية'},
    {'code': '+20', 'flag': '🇪🇬', 'name': 'مصر'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'الإمارات'},
    {'code': '+965', 'flag': '🇰🇼', 'name': 'الكويت'},
    {'code': '+973', 'flag': '🇧🇭', 'name': 'البحرين'},
    {'code': '+974', 'flag': '🇶🇦', 'name': 'قطر'},
    {'code': '+968', 'flag': '🇴🇲', 'name': 'عُمان'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => ListView(
        padding: EdgeInsets.all(16.w),
        children: _countries.map((c) {
          return ListTile(
            leading: Text(c['flag']!, style: const TextStyle(fontSize: 24)),
            title: Text(
              c['name']!,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
            ),
            trailing: Text(
              c['code']!,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedCountryCode = c['code']!;
                _selectedFlag = c['flag']!;
              });
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Navigate to OTP with reset flag
    Navigator.pushNamed(
      context,
      '/otp',
      arguments: {
        'phone': '$_selectedCountryCode${_phoneController.text}',
        'isReset': true,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ── Top Bar ──
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 18.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 20.h),

                          // ── Title ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'نسيت كلمة المرور ..!',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF1A2332),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              const Text('🗝️', style: TextStyle(fontSize: 20)),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          Text(
                            'لا تقلق! أدخل رقم جوالك وسنرسل لك تعليمات لإعادة تعيين كلمة المرور',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              color: Colors.grey.shade500,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.right,
                          ),

                          SizedBox(height: 36.h),

                          // ── Phone Field ──
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'رقم الجوال',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A2332),
                              ),
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Container(
                            height: 54.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                // Phone input
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    textAlign: TextAlign.right,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      color: const Color(0xFF1A2332),
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '501234567',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade400,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Icon(
                                          Icons.phone_android,
                                          size: 20.sp,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'رقم الجوال مطلوب';
                                      }
                                      if (v.length < 9) {
                                        return 'رقم الجوال غير صحيح';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Divider
                                Container(
                                  width: 1,
                                  height: 30.h,
                                  color: Colors.grey.shade300,
                                ),

                                // Country picker
                                GestureDetector(
                                  onTap: _showCountryPicker,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 18.sp,
                                          color: Colors.grey.shade600,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          _selectedCountryCode,
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF1A2332),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          _selectedFlag,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // ── Send Button ──
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _sendCode,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2D6A4F),
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
                                      'ارسال الرمز',
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

                          // ── Back to login ──
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'لحظة!.. تذكرت كلمة المرور',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 13.sp,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    'العودة للتسجيل',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF2D6A4F),
                                      decoration: TextDecoration.underline,
                                      decorationColor: const Color(0xFF2D6A4F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Home indicator
                          Center(
                            child: Container(
                              width: 130.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
