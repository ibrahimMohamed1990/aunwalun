// lib/features/home/presentation/screens/home_screen.dart

import 'package:Aunwanlun/core/widgets/home_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'search_results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _currentBanner = 0;
  final _pageController = PageController();

  String _selectedSector = 'قطاع الأفراد العمالة المنزلية';
  String _selectedProfession = 'عاملة تنظيف بالساعة';
  String _selectedNationality = 'كل الجنسيات';
  String _selectedPackage = 'شهر (30يوم)';

  // Banners - will come from API
  final List<Map<String, dynamic>> _banners = [
    {
      'image': 'assets/images/banner1.jpg',
      'title': 'قارن بين الأسعار\nالخدمات والمميزات',
      'subtitle': 'شفافية كاملة في الأسعار والتفاصيل\nلاتخاذ القرار الأنسب لك',
      'footer': 'كل شركات الاستقدام في مكان واحد',
    },
    {
      'image': 'assets/images/banner2.jpg',
      'title': 'أفضل الشركات\nالمعتمدة',
      'subtitle': 'شركات مرخصة من وزارة الموارد البشرية',
      'footer': 'عون ولون - منصتك الموثوقة',
    },
  ];

  final List<String> _sectors = [
    'قطاع الأفراد العمالة المنزلية',
    'قطاع العمالة المنزلية المقيمة',
    'قطاع العمالة بالساعة',
    'قطاع الرعاية الصحية',
    'قطاع الأمن والحراسة',
  ];

  final List<String> _professions = [
    'عاملة تنظيف بالساعة',
    'عاملة منزلية مقيمة',
    'ممرضة منزلية',
    'طباخ',
    'سائق',
    'حارس أمن',
  ];

  final List<String> _nationalities = [
    'كل الجنسيات',
    'مصر',
    'اثيوبيا',
    'اوغندا',
    'كينيا',
    'الفلبين',
    'سريلانكا',
    'الهند',
    'باكستان',
  ];

  final List<String> _packages = [
    'بالساعة',
    'أسبوع (7 أيام)',
    'أسبوعان (15 يوم)',
    'شهر (30يوم)',
    '60 يوم',
    '180 يوم',
    '360 يوم',
  ];

  void _showPicker(
    String title,
    List<String> options,
    Function(String) onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8.h),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.w),
              children: options.map((o) {
                return ListTile(
                  title: Text(
                    o,
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    onSelect(o);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const HomeShimmer();
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
                children: [
                  // ── Banner Slider ──
                  _buildBannerSlider(),

                  SizedBox(height: 16.h),

                  // ── Search Card ──
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildSearchCard(),
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
            // Watermark logo in header
            Positioned(
              right: 60.w,
              top: -10.h,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 160.w,
                  errorBuilder: (_, _, _) => const SizedBox(),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  // Notification Bell
                  Stack(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      Positioned(
                        top: 6.h,
                        right: 6.w,
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE53935),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'أهلاً بك في عون ولون',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13.sp,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            const Text('👋', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        Text(
                          'Ahmed Mohamed Gamal',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // Logo
                  Container(
                    width: 52.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => Icon(
                          Icons.people,
                          color: const Color(0xFF2D6A4F),
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Banner Slider ────────────────────────────────────────
  Widget _buildBannerSlider() {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentBanner = i),
            itemCount: _banners.length,
            itemBuilder: (_, i) => _buildBannerItem(_banners[i]),
          ),
        ),

        SizedBox(height: 10.h),

        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              width: _currentBanner == i ? 20.w : 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: _currentBanner == i
                    ? const Color(0xFF2D6A4F)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildBannerItem(Map<String, dynamic> banner) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: AssetImage(banner['image']),
          fit: BoxFit.cover,
          onError: (_, _) {},
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A3A2A), Color(0xFF2D6A4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [Colors.black.withValues(alpha: 0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              banner['title'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.3,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 6.h),
            Text(
              banner['subtitle'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 8.h),
            Text(
              banner['footer'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 10.sp,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Card ─────────────────────────────────────────
  Widget _buildSearchCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search hint text
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F0),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 20.sp,
                        color: const Color(0xFF2D6A4F),
                      ),
                      Positioned(
                        top: 4.h,
                        right: 4.w,
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2D6A4F),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 7.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'اختر القطاع والمهنة والباقة التي تبحث عنها، واعرض المقارنات وأفضل الأسعار من الشركات المعتمدة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      color: const Color(0xFF1A2332),
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade100),

          // Sector
          _buildDropdownItem(
            label: 'اختر القطاع',
            value: _selectedSector,
            icon: Icons.business_outlined,
            onTap: () => _showPicker(
              'اختر القطاع',
              _sectors,
              (v) => setState(() => _selectedSector = v),
            ),
            showDivider: true,
          ),

          // Profession
          _buildDropdownItem(
            label: 'اختر المهنة',
            value: _selectedProfession,
            icon: Icons.work_outline,
            onTap: () => _showPicker(
              'اختر المهنة',
              _professions,
              (v) => setState(() => _selectedProfession = v),
            ),
            showDivider: true,
          ),

          // Nationality
          _buildDropdownItem(
            label: 'الجنسية',
            value: _selectedNationality,
            icon: Icons.public,
            onTap: () => _showPicker(
              'اختر الجنسية',
              _nationalities,
              (v) => setState(() => _selectedNationality = v),
            ),
            showDivider: true,
          ),

          // Package
          _buildDropdownItem(
            label: 'اختر الباقة',
            value: _selectedPackage,
            icon: Icons.calendar_month_outlined,
            onTap: () => _showPicker(
              'اختر الباقة',
              _packages,
              (v) => setState(() => _selectedPackage = v),
            ),
            showDivider: false,
          ),

          // Search Button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/search-results');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.search, color: Colors.white, size: 20.sp),
                label: Text(
                  'البحث عن افضل العروض الان',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20.sp,
                  color: Colors.grey.shade500,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A2332),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Icon(icon, size: 22.sp, color: const Color(0xFF2D6A4F)),
              ],
            ),
          ),
        ),
        if (showDivider)
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
                onTap: () => setState(() => _currentIndex = index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Active home has avatar style
                    index == 0 && isActive
                        ? Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D6A4F),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Icon(
                              item['activeIcon'] as IconData,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          )
                        : Icon(
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
