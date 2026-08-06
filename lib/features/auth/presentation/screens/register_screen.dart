// lib/features/auth/presentation/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  String _selectedCountryCode = '+966';
  String _selectedFlag = '🇸🇦';
  String _selectedCity = 'الرياض';

  final List<Map<String, String>> _countries = [
    {'code': '+966', 'flag': '🇸🇦', 'name': 'السعودية'},
    {'code': '+20', 'flag': '🇪🇬', 'name': 'مصر'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'الإمارات'},
    {'code': '+965', 'flag': '🇰🇼', 'name': 'الكويت'},
    {'code': '+973', 'flag': '🇧🇭', 'name': 'البحرين'},
    {'code': '+974', 'flag': '🇶🇦', 'name': 'قطر'},
    {'code': '+968', 'flag': '🇴🇲', 'name': 'عُمان'},
    {'code': '+962', 'flag': '🇯🇴', 'name': 'الأردن'},
  ];

  final List<String> _cities = [
    'الرياض',
    'جدة',
    'مكة المكرمة',
    'المدينة المنورة',
    'الدمام',
    'الخبر',
    'الطائف',
    'بريدة',
    'تبوك',
    'أبها',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  void _showCityPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => ListView(
        padding: EdgeInsets.all(16.w),
        children: _cities.map((city) {
          return ListTile(
            title: Text(
              city,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
              textAlign: TextAlign.right,
            ),
            onTap: () {
              setState(() => _selectedCity = city);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushNamed(
      context,
      '/otp',
      arguments: {'phone': '$_selectedCountryCode${_phoneController.text}'},
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
            top: 60.h,
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 8.h),

                          // ── Title ──
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'إنشاء حساب جديد',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF1A2332),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.person_outline,
                                color: const Color(0xFF2D6A4F),
                                size: 24.sp,
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),

                          Text(
                            'فقل حسابك في ثواني واستمتع بتجربة طلب خدمتك\nبسهولة وراحة وأمان',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              color: Colors.grey.shade500,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.right,
                          ),

                          SizedBox(height: 24.h),

                          // ── Full Name ──
                          _buildLabel('الاسم بالكامل'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Ahmed Mohamed Gamal',
                            suffixIcon: Icons.person_outline,
                            validator: (v) =>
                                v == null || v.isEmpty ? 'الاسم مطلوب' : null,
                          ),

                          SizedBox(height: 16.h),

                          // ── Phone ──
                          _buildLabel('رقم الجوال'),
                          SizedBox(height: 8.h),
                          _buildPhoneField(),

                          SizedBox(height: 16.h),

                          // ── Email ──
                          _buildLabel('البريد الإلكتروني'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _emailController,
                            hint: 'ahmedhoss12@gmail.com',
                            suffixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'البريد الإلكتروني مطلوب';
                              }
                              if (!v.contains('@')) {
                                return 'البريد الإلكتروني غير صحيح';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // ── Username ──
                          _buildLabel('اسم المستخدم'),
                          SizedBox(height: 8.h),
                          _buildTextField(
                            controller: _usernameController,
                            hint: 'ahmedmohamad22',
                            suffixIcon: Icons.alternate_email,
                            validator: (v) => v == null || v.isEmpty
                                ? 'اسم المستخدم مطلوب'
                                : null,
                          ),

                          SizedBox(height: 16.h),

                          // ── City ──
                          _buildLabel('المدينة'),
                          SizedBox(height: 8.h),
                          _buildCityField(),

                          SizedBox(height: 16.h),

                          // ── Password ──
                          _buildLabel('كلمة المرور'),
                          SizedBox(height: 8.h),
                          _buildPasswordField(
                            controller: _passwordController,
                            obscure: _obscurePassword,
                            onToggle: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'كلمة المرور مطلوبة';
                              }
                              if (v.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // ── Confirm Password ──
                          _buildLabel('تأكيد كلمة المرور'),
                          SizedBox(height: 8.h),
                          _buildPasswordField(
                            controller: _confirmPasswordController,
                            obscure: _obscureConfirm,
                            onToggle: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'تأكيد كلمة المرور مطلوب';
                              }
                              if (v != _passwordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 28.h),

                          // ── Register Button ──
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _register,
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
                                      'انشاء حساب',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),

                          SizedBox(height: 20.h),

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

  // ── Helper Widgets ────────────────────────────────────

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1A2332),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        validator: validator,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14.sp,
          color: const Color(0xFF1A2332),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            color: Colors.grey.shade400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: Icon(suffixIcon, size: 20.sp, color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
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
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
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
                if (v == null || v.isEmpty) return 'رقم الجوال مطلوب';
                if (v.length < 9) return 'رقم الجوال غير صحيح';
                return null;
              },
            ),
          ),
          Container(width: 1, height: 30.h, color: Colors.grey.shade300),
          GestureDetector(
            onTap: _showCountryPicker,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                  Text(_selectedFlag, style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityField() {
    return GestureDetector(
      onTap: _showCityPicker,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.sp,
              color: Colors.grey.shade600,
            ),
            const Spacer(),
            Text(
              _selectedCity,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: const Color(0xFF1A2332),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.location_city_outlined,
              size: 20.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              textAlign: TextAlign.right,
              validator: validator,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: const Color(0xFF1A2332),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Icon(
                    Icons.lock_outline,
                    size: 20.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
