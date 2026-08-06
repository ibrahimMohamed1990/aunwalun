// lib/features/home/presentation/screens/search_results_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String _sortBy = 'السعر';

  // for test
  //final List<Map<String, dynamic>> _results = [];
  final List<Map<String, dynamic>> _results = [
    {
      'company': 'شركة إعتناء للموارد البشرية',
      'sector': 'قطاع العمل بالساعة',
      'profession': 'عاملة منزليه مقيمة',
      'nationality': 'أوغندا',
      'package': 'شهر',
      'price': '1,599',
      'logo': 'assets/images/company1.png',
    },
    {
      'company': 'شركة إعتناء للموارد البشرية',
      'sector': 'قطاع الأفراد العمالة المنزلية',
      'profession': 'ممرضة منزلية',
      'nationality': 'الفلبين',
      'package': 'بالساعة',
      'price': '1,750',
      'logo': 'assets/images/company2.png',
    },
    {
      'company': 'شركة النور للخدمات المنزلية',
      'sector': 'قطاع العمالة المنزلية',
      'profession': 'عاملة تنظيف',
      'nationality': 'اثيوبيا',
      'package': '60 يوم',
      'price': '2,100',
      'logo': 'assets/images/company3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 16.h),

                    // ── Request Details Card ──
                    _buildRequestDetailsCard(),

                    SizedBox(height: 16.h),

                    // ── Results Header ──
                    _buildResultsHeader(),

                    SizedBox(height: 12.h),

                    // ── Result Cards ──
                    _results.isEmpty
                        ? _buildEmptyState()
                        : Column(
                            children: _results
                                .map((r) => _buildResultCard(r))
                                .toList(),
                          ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App Bar ─────────────────────────────────────────────
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
            'نتائج البحث المُتاحة',
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

  // ── Request Details Card ────────────────────────────────
  Widget _buildRequestDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F0),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D6A4F).withValues(alpha: 0.2),
        ),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تفاصيل طلبك',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2332),
                ),
              ),
              SizedBox(width: 6.w),
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: const Color(0xFF2D6A4F),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Details Grid
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.edit_outlined,
                  label: 'القطاع:',
                  value: 'قطاع الأفراد العمالة المنزلية',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.edit_outlined,
                  label: 'المهنة:',
                  value: 'عاملة منزليه مقيمة',
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.edit_outlined,
                  label: 'الباقة:',
                  value: 'كل الباقات',
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.edit_outlined,
                  label: 'الجنسية:',
                  value: 'كل الجنسيات',
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Found text
          Text(
            'تم العثور على 6 باقات تعاقدية من شركات مرخصة من وزارة الموارد البشرية',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11.sp,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(icon, size: 14.sp, color: Colors.grey.shade500),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2332),
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  // ── Results Header ──────────────────────────────────────
  Widget _buildResultsHeader() {
    return Row(
      children: [
        // Sort button
        GestureDetector(
          onTap: () {
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
                  SizedBox(height: 16.h),
                  Text(
                    'ترتيب حسب',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...['السعر', 'التقييم', 'الأحدث'].map(
                    (s) => ListTile(
                      title: Text(
                        s,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
                        textAlign: TextAlign.right,
                      ),
                      trailing: _sortBy == s
                          ? Icon(Icons.check, color: const Color(0xFF2D6A4F))
                          : null,
                      onTap: () {
                        setState(() => _sortBy = s);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.swap_vert,
                  size: 16.sp,
                  color: const Color(0xFF2D6A4F),
                ),
                SizedBox(width: 4.w),
                Text(
                  'ترتيب حسب: $_sortBy',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A2332),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        // Results count
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'نتائج البحث',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A2332),
              ),
            ),
            Text(
              '${_results.length} مقدمين خدمات في انتظارك',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Result Card ─────────────────────────────────────────
  Widget _buildResultCard(Map<String, dynamic> result) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Company Header ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                // Company Logo
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5F0),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFF2D6A4F).withValues(alpha: 0.2),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      result['logo'],
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => Icon(
                        Icons.business,
                        color: const Color(0xFF2D6A4F),
                        size: 22.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                // Company Name & Sector
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        result['sector'],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Text(
                        result['company'],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A2332),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade100),

          // ── Details Row ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCardDetail('الباقة:', result['package']),
                _buildCardDetail('الجنسية:', result['nationality']),
                _buildCardDetail('المهنة:', result['profession']),
              ],
            ),
          ),

          // ── Price & Button ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                // Submit Button
                Expanded(
                  child: SizedBox(
                    height: 46.h,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/order-form',
                          arguments: result,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2D6A4F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                      label: Text(
                        'قدم طلبك',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
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
                              fontSize: 12.sp,
                              color: const Color(0xFF1A2332),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: result['price'],
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

  Widget _buildCardDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 11.sp,
            color: Colors.grey.shade500,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A2332),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.sentiment_neutral_outlined,
                    size: 56.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
                Positioned(
                  top: -12.h,
                  child: Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.question_mark_rounded,
                      size: 18.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -8.h,
                  right: -8.w,
                  child: Icon(
                    Icons.search,
                    size: 28.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            Text(
              'لا توجد نتائج تطابق بحثك',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A2332),
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'من فضلك اختار تفاصيل اخري او قم بالتعديل علي\nبيانات طلبك',
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
      ),
    );
  }
}
