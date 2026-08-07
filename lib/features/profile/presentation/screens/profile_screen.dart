// lib/features/profile/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  int _currentIndex = 2;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'المعلومات الشخصية',
      'subtitle': 'تعديل البيانات الشخصية',
      'icon': Icons.person_outline,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF3B82F6),
      'type': 'arrow',
      'route': '/edit-profile',
    },
    {
      'title': 'كلمة المرور',
      'subtitle': 'تعديل كلمة المرورالخاصة بك',
      'icon': Icons.lock_outline,
      'iconBg': Color(0xFFE8F5F0),
      'iconColor': Color(0xFF2D6A4F),
      'type': 'arrow',
      'route': '/change-password',
    },
    {
      'title': 'الاشعارات',
      'subtitle': null,
      'icon': Icons.notifications_outlined,
      'iconBg': Color(0xFFFFF8E1),
      'iconColor': Color(0xFFF59E0B),
      'type': 'toggle',
      'key': 'notifications',
    },
    {
      'title': 'المظهر الداكن',
      'subtitle': null,
      'icon': Icons.dark_mode_outlined,
      'iconBg': Color(0xFFE0F7FA),
      'iconColor': Color(0xFF00B894),
      'type': 'toggle',
      'key': 'darkMode',
    },
    {
      'title': 'اللغة',
      'subtitle': null,
      'icon': Icons.language,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF3B82F6),
      'type': 'arrow',
      'route': '/language',
    },
    {
      'title': 'تقييم التطبيق علي المتجر',
      'subtitle': null,
      'icon': Icons.star_outline,
      'iconBg': Color(0xFFE8F5F0),
      'iconColor': Color(0xFF2D6A4F),
      'type': 'arrow',
      'route': '/rate',
    },
    {
      'title': 'مشاركة التطبيق',
      'subtitle': null,
      'icon': Icons.share_outlined,
      'iconBg': Color(0xFFFFF8E1),
      'iconColor': Color(0xFFF59E0B),
      'type': 'arrow',
      'route': '/share',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Column(
        children: [
          // ── Header ──
          _buildHeader(),

          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 20.h),

                  // Section label
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'الحساب والإعدادات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // ── Menu Items ──
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: List.generate(_menuItems.length, (i) {
                        final item = _menuItems[i];
                        final isLast = i == _menuItems.length - 1;
                        return _buildMenuItem(item, isLast);
                      }),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // ── Logout ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showLogoutDialog();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: const Color(0xFFE53935),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.logout,
                          color: const Color(0xFFE53935),
                          size: 20.sp,
                        ),
                        label: Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFE53935),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // ── Bottom Nav ──
          _buildBottomNav(),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A3A2A), Color(0xFF2D6A4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Decorative elements
            Positioned(
              left: 20.w,
              top: 20.h,
              child: _DecorativeShape(size: 30.r),
            ),
            Positioned(
              left: 60.w,
              bottom: 30.h,
              child: _DecorativeShape(size: 14.r, isSquare: true),
            ),
            Positioned(
              right: 30.w,
              top: 60.h,
              child: _DecorativeShape(size: 12.r, isSquare: true),
            ),
            Positioned(
              left: 30.w,
              top: 80.h,
              child: Icon(Icons.add, color: Colors.white24, size: 16.sp),
            ),
            Positioned(
              right: 80.w,
              bottom: 20.h,
              child: Icon(Icons.add, color: Colors.white24, size: 16.sp),
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: Colors.white24,
                          child: Icon(
                            Icons.person,
                            size: 50.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Name
                  Text(
                    'Ahmed Mohamed Gamal',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Email
                  Text(
                    'ahmedhoss12@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      color: Colors.white70,
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Menu Item ────────────────────────────────────────────
  Widget _buildMenuItem(Map<String, dynamic> item, bool isLast) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              // Arrow or Toggle
              if (item['type'] == 'arrow')
                Icon(
                  Icons.chevron_left,
                  size: 22.sp,
                  color: Colors.grey.shade400,
                )
              else if (item['type'] == 'toggle')
                Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    value: item['key'] == 'notifications'
                        ? _notificationsEnabled
                        : _darkModeEnabled,
                    onChanged: (v) {
                      setState(() {
                        if (item['key'] == 'notifications') {
                          _notificationsEnabled = v;
                        } else {
                          _darkModeEnabled = v;
                        }
                      });
                    },
                    activeThumbColor: const Color(0xFF2D6A4F),
                    activeTrackColor: const Color(
                      0xFF2D6A4F,
                    ).withValues(alpha: 0.3),
                  ),
                ),

              const Spacer(),

              // Title & Subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A2332),
                    ),
                  ),
                  if (item['subtitle'] != null)
                    Text(
                      item['subtitle'],
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),

              SizedBox(width: 12.w),

              // Icon
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: item['iconBg'] as Color,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['iconColor'] as Color,
                  size: 22.sp,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade100,
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }

  // ── Logout Dialog ────────────────────────────────────────
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'تسجيل الخروج',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'هل أنت متأكد من تسجيل الخروج؟',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14.sp,
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
              'تسجيل الخروج',
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

  // ── Bottom Nav ──────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {
        'icon': Icons.settings_outlined,
        'activeIcon': Icons.settings,
        'label': 'حسابي',
        'index': 2,
      },
      {
        'icon': Icons.list_alt_outlined,
        'activeIcon': Icons.list_alt,
        'label': 'طلباتي',
        'index': 1,
      },
      {
        'icon': Icons.home_outlined,
        'activeIcon': Icons.home,
        'label': 'الرئيسية',
        'index': 0,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              final index = item['index'] as int;
              final isActive = _currentIndex == index;
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (index == 1) {
                    Navigator.pushReplacementNamed(context, '/my-orders');
                  } else {
                    setState(() => _currentIndex = index);
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive
                          ? item['activeIcon'] as IconData
                          : item['icon'] as IconData,
                      size: 26.sp,
                      color: isActive
                          ? const Color(0xFF2D6A4F)
                          : Colors.grey.shade400,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item['label'] as String,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11.sp,
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isActive
                            ? const Color(0xFF2D6A4F)
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// ── Decorative Shape ─────────────────────────────────────
class _DecorativeShape extends StatelessWidget {
  final double size;
  final bool isSquare;
  const _DecorativeShape({required this.size, this.isSquare = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white24, width: 1.5),
        borderRadius: isSquare ? BorderRadius.circular(4) : null,
        shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
      ),
    );
  }
}
