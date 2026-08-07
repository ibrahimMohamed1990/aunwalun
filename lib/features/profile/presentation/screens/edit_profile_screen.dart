// lib/features/profile/presentation/screens/edit_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ahmed Mohamed Gamal');
  final _phoneController = TextEditingController(text: '501234567');
  final _emailController = TextEditingController(text: 'ahmedhoss12@gmail.com');
  final _usernameController = TextEditingController(text: 'ahmedmohamad22');

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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم حفظ التغييرات بنجاح',
          style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
        ),
        backgroundColor: const Color(0xFF2D6A4F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'حذف الحساب',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFE53935),
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/welcome',
                (_) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'حذف الحساب',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ── App Bar ──
              _buildAppBar(),

              // ── Body ──
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 24.h),

                      // ── Avatar ──
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/avatar.png',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey.shade100,
                                        child: Icon(
                                          Icons.person,
                                          size: 50.sp,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () {
                                // Pick image
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'تغيير الصورة',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2D6A4F),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  const Text(
                                    '✏️',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // ── Full Name ──
                      _buildLabel('الاسم بالكامل'),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: _nameController,
                        suffixIcon: Icons.person_outline,
                        validator: (v) => v!.isEmpty ? 'الاسم مطلوب' : null,
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
                        suffixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v!.isEmpty) return 'البريد مطلوب';
                          if (!v.contains('@')) return 'بريد غير صحيح';
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      // ── Username ──
                      _buildLabel('اسم المستخدم'),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: _usernameController,
                        suffixIcon: Icons.alternate_email,
                        validator: (v) =>
                            v!.isEmpty ? 'اسم المستخدم مطلوب' : null,
                      ),

                      SizedBox(height: 16.h),

                      // ── City ──
                      _buildLabel('المدينة'),
                      SizedBox(height: 8.h),
                      _buildCityField(),

                      SizedBox(height: 32.h),

                      // ── Save Button ──
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _save,
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
                                  'حفظ التغييرات',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // ── Delete Account ──
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: OutlinedButton(
                          onPressed: _showDeleteAccountDialog,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: const Color(0xFFE53935),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            'حذف الحساب',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFE53935),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36.w,
              height: 36.h,
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
          const Spacer(),
          Text(
            'المعلومات الشخصية',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A2332),
            ),
          ),
        ],
      ),
    );
  }

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
                if (v!.isEmpty) return 'رقم الجوال مطلوب';
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
}
