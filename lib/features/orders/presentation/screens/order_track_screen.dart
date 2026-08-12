// lib/features/orders/presentation/screens/order_track_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTrackScreen extends StatefulWidget {
  const OrderTrackScreen({super.key});

  @override
  State<OrderTrackScreen> createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  bool _showCustomerDetails = false;
  bool _showOrderDetails = false;
  bool _showScheduleDetails = false;

  final String _currentStatus = 'waiting_customer';

  final List<Map<String, dynamic>> _timeline = [
    {
      'key': 'new',
      'title': 'طلب جديد',
      'desc': 'تم إرسال طلبك بنجاح وجاري معالجته',
      'date': '١٥ يوليو ٢٠٢٥ - ١٠:٣٠ ص',
      'emoji': '🧾',
      'done': true,
      'active': false,
    },
    {
      'key': 'under_review',
      'title': 'قيد المراجعة',
      'desc': 'فريقنا يراجع بيانات طلبك للتأكد من اكتمال المعلومات',
      'date': '١٥ يوليو ٢٠٢٥ - ١١:٠٠ ص',
      'emoji': '⏳',
      'done': true,
      'active': false,
    },
    {
      'key': 'offers_sent',
      'title': 'تم إرسال العروض',
      'desc': 'تم إرسال طلبك للشركات المعتمدة وجاري استقبال عروض الأسعار',
      'date': '١٦ يوليو ٢٠٢٥ - ٩:١٥ ص',
      'emoji': '📨',
      'done': true,
      'active': false,
    },
    {
      'key': 'waiting_customer',
      'title': 'بانتظار موافقة العميل',
      'desc': 'تم استلام العروض، يرجى مراجعة العروض وتاكيد طلبك',
      'date': '١٧ يوليو ٢٠٢٥ - ٢:٤٥ م',
      'emoji': '⏰',
      'done': false,
      'active': true,
    },
    {
      'key': 'confirmed',
      'title': 'مؤكد',
      'desc': 'في انتظار المرحلة السابقة',
      'date': '',
      'emoji': '👍',
      'done': false,
      'active': false,
    },
    {
      'key': 'in_progress',
      'title': 'قيد التنفيذ',
      'desc': 'في انتظار المرحلة السابقة',
      'date': '',
      'emoji': '⚙️',
      'done': false,
      'active': false,
    },
    {
      'key': 'completed',
      'title': 'تم تنفيذ الخدمة بنجاح',
      'desc': 'في انتظار المرحلة السابقة',
      'date': '',
      'emoji': '🗓️',
      'done': false,
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    final orderId = args['order_id'] ?? '62';

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(orderId.toString()),

            // ── Body ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 16.h),

                    // ── Service Card ──
                    _buildServiceCard(),

                    SizedBox(height: 20.h),

                    // ── Timeline Title ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'مراحل الطلب',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1A2332),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Timeline ──
                    _buildTimeline(),

                    SizedBox(height: 20.h),

                    // ── Collapsible Sections ──
                    _buildCollapsible(
                      title: 'بيانات العميل',
                      isOpen: _showCustomerDetails,
                      onTap: () => setState(
                        () => _showCustomerDetails = !_showCustomerDetails,
                      ),
                      child: _buildCustomerDetails(),
                    ),

                    SizedBox(height: 10.h),

                    _buildCollapsible(
                      title: 'تفاصيل الطلب',
                      isOpen: _showOrderDetails,
                      onTap: () => setState(
                        () => _showOrderDetails = !_showOrderDetails,
                      ),
                      child: _buildOrderDetails(),
                    ),

                    SizedBox(height: 10.h),

                    _buildCollapsible(
                      title: 'تفاصيل الجدولة',
                      isOpen: _showScheduleDetails,
                      onTap: () => setState(
                        () => _showScheduleDetails = !_showScheduleDetails,
                      ),
                      child: _buildScheduleDetails(),
                    ),

                    SizedBox(height: 24.h),
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
  Widget _buildAppBar(String orderId) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'تفاصيل الطلب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2332),
                ),
              ),
              Text(
                'رقم الطلب: #$orderId',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
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
          // Company Logo
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

          // Service Info
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

  // ── Timeline ────────────────────────────────────────────
  Widget _buildTimeline() {
    return Container(
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
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: List.generate(_timeline.length, (i) {
          final item = _timeline[i];
          final isLast = i == _timeline.length - 1;
          return _buildTimelineItem(item, isLast);
        }),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> item, bool isLast) {
    final isDone = item['done'] as bool;
    final isActive = item['active'] as bool;
    final isPending = !isDone && !isActive;

    Color lineColor = isDone ? const Color(0xFF2D6A4F) : Colors.grey.shade200;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content (RTL - content on right)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 12.w, bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      fontWeight: isActive || isDone
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: isPending
                          ? Colors.grey.shade400
                          : const Color(0xFF1A2332),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Description
                  Text(
                    item['desc'],
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12.sp,
                      color: isPending
                          ? Colors.grey.shade300
                          : Colors.grey.shade500,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  if ((item['date'] as String).isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      item['date'],
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Timeline line + dot
          Column(
            children: [
              // Emoji/Icon circle
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDone
                      ? const Color(0xFFE8F5F0)
                      : isActive
                      ? const Color(0xFFFFF8E1)
                      : Colors.grey.shade100,
                  border: Border.all(
                    color: isDone
                        ? const Color(0xFF2D6A4F)
                        : isActive
                        ? const Color(0xFFF59E0B)
                        : Colors.grey.shade200,
                    width: isActive ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    item['emoji'],
                    style: TextStyle(fontSize: isPending ? 16.sp : 20.sp),
                  ),
                ),
              ),

              // Vertical line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: lineColor,
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Collapsible Section ──────────────────────────────────
  Widget _buildCollapsible({
    required String title,
    required bool isOpen,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: isOpen ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 22.sp,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1A2332),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                Divider(height: 1, color: Colors.grey.shade100),
                child,
              ],
            ),
            crossFadeState: isOpen
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  // ── Customer Details ─────────────────────────────────────
  Widget _buildCustomerDetails() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildDetailRow('الاسم', 'Ahmed Mohamed Gamal'),
          _buildDetailRow('رقم الجوال', '+966 501234567'),
          _buildDetailRow('البريد الإلكتروني', 'ahmedhoss12@gmail.com'),
          _buildDetailRow('المدينة', 'الرياض'),
        ],
      ),
    );
  }

  // ── Order Details ────────────────────────────────────────
  Widget _buildOrderDetails() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildDetailRow('نوع العمالة', 'فردي'),
          _buildDetailRow('الجنسية المطلوبة', 'اوغاندا'),
          _buildDetailRow('عدد العمالة', '1'),
          _buildDetailRow('مدة العمل', '30 يوم'),
          _buildDetailRow('الباقة', 'شهر (30 يوم)'),
          _buildDetailRow(
            'السعر شامل الضريبة',
            '1,750 ريال',
            valueColor: const Color(0xFF2D6A4F),
          ),
        ],
      ),
    );
  }

  // ── Schedule Details ─────────────────────────────────────
  Widget _buildScheduleDetails() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildDetailRow('من', '2026/07/20'),
          _buildDetailRow('إلى', '2026/08/20'),
          _buildDetailRow('وقت الوصول', 'صباحاً'),
          _buildDetailRow('ملاحظات', 'لا توجد ملاحظات'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? const Color(0xFF1A2332),
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
