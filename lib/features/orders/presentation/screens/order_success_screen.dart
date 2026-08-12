// lib/features/orders/presentation/screens/order_success_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final orderId = args['order_id'] ?? '62';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 60.h),

                    // ── Success Message ──
                    _buildSuccessHeader(orderId.toString()),

                    SizedBox(height: 20.h),

                    // ── Service Card ──
                    _buildServiceCard(),

                    SizedBox(height: 20.h),

                    // ── Customer Details ──
                    _buildSection(
                      title: 'بيانات العميل',
                      child: _buildCustomerDetails(),
                    ),

                    SizedBox(height: 16.h),

                    // ── Order Details ──
                    _buildSection(
                      title: 'تفاصيل الطلب',
                      child: _buildOrderDetails(),
                    ),

                    SizedBox(height: 16.h),

                    // ── Schedule Details ──
                    _buildSection(
                      title: 'تفاصيل الجدولة',
                      child: _buildScheduleDetails(),
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // ── Bottom Buttons ──
            _buildBottomButtons(context, orderId.toString()),
          ],
        ),
      ),
    );
  }

  // ── Success Header ──────────────────────────────────────
  Widget _buildSuccessHeader(String orderId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('✅', style: TextStyle(fontSize: 22)),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'تم تقديم طلبكم بنجاح، وجار العمل عليه',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1A2332),
                  height: 1.4,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),

        SizedBox(height: 10.h),

        Text(
          'سيتم التواصل معكم من قبل القسم المختص و إشعاركم عند تحديث حالة الطلب، ولمتابعة حالة الطلب',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            color: Colors.grey.shade500,
            height: 1.6,
          ),
          textAlign: TextAlign.right,
        ),

        SizedBox(height: 10.h),

        Align(
          alignment: Alignment.centerRight,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '#$orderId',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2D6A4F),
                  ),
                ),
                TextSpan(
                  text: ' رقم الطلب: ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A2332),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Service Card ────────────────────────────────────────
  Widget _buildServiceCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D6A4F).withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(14.w),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFF2D6A4F).withOpacity(0.15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                'assets/images/company1.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.business,
                  color: const Color(0xFF2D6A4F),
                  size: 22.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'عاملة منزلية مقيمة - اوغاندا',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A2332),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'مقدم من: شركة إعتناء للموارد البشرية | الرياض',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Wrapper ──────────────────────────────────────
  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1A2332),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.w),
          child: child,
        ),
      ],
    );
  }

  // ── Customer Details ─────────────────────────────────────
  Widget _buildCustomerDetails() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(
                label: 'رقم الجوال:',
                value: '+966 501234567',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(
                label: 'اسم العميل:',
                value: 'Ahmed Mohamed Gamal',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(label: 'المدينة:', value: 'الرياض'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(
                label: 'البريد الإلكتروني:',
                value: 'ahmedhoss12@gmail.com',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Order Details ────────────────────────────────────────
  Widget _buildOrderDetails() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(label: 'الجنسية:', value: 'عربية'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(
                label: 'نوع العمالة:',
                value: 'عمالة أفريقية',
                valueWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(
                label: 'مدة العمل (بالأيام):',
                value: '8',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(label: 'عدد العمالة:', value: '2 عامل'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(
                label: 'السعر شامل الضريبة:',
                value: '1599.00 ريال',
                valueColor: const Color(0xFF2D6A4F),
                valueWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(label: 'الباقة:', value: 'شهر (30 يوم)'),
            ),
          ],
        ),
      ],
    );
  }

  // ── Schedule Details ─────────────────────────────────────
  Widget _buildScheduleDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDetailCell(
                label: 'تاريخ الانتهاء:',
                value: '2027/09/25',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildDetailCell(
                label: 'تاريخ البداية:',
                value: '2027/08/25',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildDetailCell(label: 'وقت الوصول:', value: 'صباحاً'),
        SizedBox(height: 12.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'ملاحظات إضافية:',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12.sp,
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'تفضيل عاملة تجيد الطبخ السعودي و يفضل ان تكون تتحدث الانجليزية و تستطيع ايضاً رعاية الاطفال وكبار السن',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A2332),
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailCell({
    required String label,
    required String value,
    Color? valueColor,
    FontWeight? valueWeight,
  }) {
    return Column(
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
        SizedBox(height: 3.h),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            fontWeight: valueWeight ?? FontWeight.w700,
            color: valueColor ?? const Color(0xFF1A2332),
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  // ── Bottom Buttons ──────────────────────────────────────
  Widget _buildBottomButtons(BuildContext context, String orderId) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // View Order Details
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/track-order',
                  arguments: {'order_id': orderId},
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D6A4F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              icon: const Text('📋', style: TextStyle(fontSize: 18)),
              label: Text(
                'عرض تفاصيل الطلب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Go Home
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (_) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: const Color(0xFF2D6A4F), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              icon: const Text('🏠', style: TextStyle(fontSize: 18)),
              label: Text(
                'رجوع إلى الرئيسية',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D6A4F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
