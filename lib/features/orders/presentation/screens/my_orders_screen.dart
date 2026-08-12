// lib/features/orders/presentation/screens/my_orders_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _currentIndex = 1;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _orders = [
    {
      'id': '62',
      'status': 'new',
      'statusLabel': 'طلب جديد',
      'statusColor': Color(0xFF2D6A4F),
      'statusBg': Color(0xFFE8F5F0),
      'company': 'شركة إعتناء للموارد البشرية',
      'logo': 'assets/images/company1.png',
      'date': '2026/07/14',
      'laborType': 'تنظيف بالساعة',
      'nationality': 'عربية',
      'package': 'شهر (30يوم)',
      'total': '1,750',
    },
    {
      'id': '63',
      'status': 'under_review',
      'statusLabel': 'طلب قيد المعالجة',
      'statusColor': Color(0xFFF59E0B),
      'statusBg': Color(0xFFFFF8E1),
      'company': 'مؤسسة النخبة للخدمات',
      'logo': 'assets/images/company2.png',
      'date': '2026/07/15',
      'laborType': 'رعاية منزلية',
      'nationality': 'آسيوية',
      'package': 'أسبوع (7 أيام)',
      'total': '2,100',
    },
    {
      'id': '64',
      'status': 'confirmed',
      'statusLabel': 'مؤكد',
      'statusColor': Color(0xFF3B82F6),
      'statusBg': Color(0xFFE8F0FE),
      'company': 'شركة النور للخدمات',
      'logo': 'assets/images/company3.png',
      'date': '2026/07/10',
      'laborType': 'عاملة منزلية',
      'nationality': 'اثيوبية',
      'package': '60 يوم',
      'total': '3,200',
    },
    {
      'id': '65',
      'status': 'completed',
      'statusLabel': 'تم تنفيذ الخدمة بنجاح',
      'statusColor': Color(0xFF2D6A4F),
      'statusBg': Color(0xFFE8F5F0),
      'company': 'شركة الرعاية المتميزة',
      'logo': 'assets/images/company4.png',
      'date': '2026/06/20',
      'laborType': 'طباخ',
      'nationality': 'فلبينية',
      'package': '180 يوم',
      'total': '8,500',
    },
    {
      'id': '61',
      'status': 'cancelled',
      'statusLabel': 'ملغي',
      'statusColor': Color(0xFFE53935),
      'statusBg': Color(0xFFFFEBEE),
      'company': 'شركة الأمانة للاستقدام',
      'logo': 'assets/images/company5.png',
      'date': '2026/06/01',
      'laborType': 'حارس أمن',
      'nationality': 'مصرية',
      'package': 'أسبوعان (15 يوم)',
      'total': '1,200',
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_searchQuery.isEmpty) return _orders;
    return _orders.where((o) {
      return o['company'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          o['laborType'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          o['nationality'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          o['id'].toString().contains(_searchQuery);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Column(
        children: [
          // ── Header ──
          _buildHeader(),

          // ── Search Bar ──
          _buildSearchBar(),

          // ── Orders List ──
          Expanded(
            child: _filteredOrders.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (_, i) => _buildOrderCard(_filteredOrders[i]),
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
            Positioned(
              right: 40.w,
              top: -10.h,
              child: Opacity(
                opacity: 0.07,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 140.w,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Center(
                child: Text(
                  'طلباتي',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          // Filter button
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D6A4F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.tune, color: Colors.white, size: 20.sp),
          ),

          SizedBox(width: 10.w),

          // Search field
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  color: const Color(0xFF1A2332),
                ),
                decoration: InputDecoration(
                  hintText: 'ابحث باسم الشركة او المهنة او الجنسية ...',
                  hintStyle: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                ),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Order Card ──────────────────────────────────────────
  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Card Header ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: order['statusBg'] as Color,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    order['statusLabel'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: order['statusColor'] as Color,
                    ),
                  ),
                ),

                const Spacer(),

                // Order number
                Text(
                  'رقم الطلب: #${order['id']}',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade100),

          // ── Company Info ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                // Logo
                Container(
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F0),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFF2D6A4F).withOpacity(0.15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      order['logo'],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.business,
                        color: const Color(0xFF2D6A4F),
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order['company'],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A2332),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            order['date'],
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'تاريخ الطلب:',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Details Row ──
          Container(
            margin: EdgeInsets.symmetric(horizontal: 14.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailChip('الباقة:', order['package']),
                _buildDivider(),
                _buildDetailChip('الجنسية:', order['nationality']),
                _buildDivider(),
                _buildDetailChip('نوع العمالة:', order['laborType']),
              ],
            ),
          ),

          // ── Footer ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Track button
                Expanded(
                  child: SizedBox(
                    height: 44.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/track-order',
                          arguments: {'order_id': order['id']},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      label: Text(
                        'تتبع الطلب',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الاجمالي شامل الضريبة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ' ريال',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11.sp,
                              color: const Color(0xFF1A2332),
                            ),
                          ),
                          TextSpan(
                            text: order['total'],
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1A2332),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailChip(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10.sp,
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2332),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 30.h, color: Colors.grey.shade200);
  }

  // ── Empty State ──────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          SizedBox(
            width: 200.w,
            height: 200.h,
            child: Image.asset(
              'assets/images/empty_orders.png',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Stack(
                alignment: Alignment.center,
                children: [
                  // Bowl shape
                  Container(
                    width: 160.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5F0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80.r),
                        bottomRight: Radius.circular(80.r),
                      ),
                    ),
                  ),
                  // Papers inside bowl
                  Positioned(
                    top: 20.h,
                    child: Container(
                      width: 80.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 3.h,
                            ),
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5F0),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  // Small cloud on top
                  Positioned(
                    top: 0,
                    left: 20.w,
                    child: Container(
                      width: 50.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB2DFDB),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            'لا توجد طلبات حتى الآن',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1A2332),
            ),
          ),

          SizedBox(height: 10.h),

          Text(
            'ستظهر هنا جميع طلبات العمالةالخاصة\nبطلباتك بجميع حالات الطلب',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              color: Colors.grey.shade500,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
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
        'route': '/profile',
      },
      {
        'icon': Icons.list_alt_outlined,
        'activeIcon': Icons.list_alt,
        'label': 'طلباتي',
        'index': 1,
        'route': '/my-orders',
      },
      {
        'icon': Icons.home_outlined,
        'activeIcon': Icons.home,
        'label': 'الرئيسية',
        'index': 0,
        'route': '/home',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
                  if (index != _currentIndex) {
                    Navigator.pushReplacementNamed(
                      context,
                      item['route'] as String,
                    );
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
