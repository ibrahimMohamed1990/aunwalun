// lib/features/notifications/presentation/screens/notifications_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'تم تحديث حالة طلبك',
      'isUnread': true,
      'subtitle': 'طلبك #100 في انتظار تأكيد الشركة',
      'body': 'شركة NATREC تراجع طلبك حالياً، سيتم التواصل معك خلال 24 ساعة',
      'date': '15 يناير 2026',
      'time': '03:00 مساء',
      'icon': Icons.receipt_long_outlined,
      'iconBg': Color(0xFFE8F5F0),
      'iconColor': Color(0xFF2D6A4F),
      'accentColor': Color(0xFF2D6A4F),
    },
    {
      'title': 'عرض خاص!',
      'isUnread': true,
      'subtitle': 'خصم 15% على استقدام عاملة منزلية',
      'body':
          'احصل على خصم خاص من شركة NATREC على باقة الشهر الكامل - العرض ساري حتى نهاية الأسبوع',
      'date': '14 يناير 2026',
      'time': '03:00 مساء',
      'icon': Icons.local_offer_outlined,
      'iconBg': Color(0xFFFFF8E1),
      'iconColor': Color(0xFFF59E0B),
      'accentColor': Color(0xFFF59E0B),
    },
    {
      'title': 'رسالة من NATREC',
      'isUnread': false,
      'subtitle': 'شركة NATREC أرسلت لك رسالة',
      'body':
          'مرحباً، نود إعلامك أن العاملة المنزلية ستكون جاهزة يوم الأحد القادم.',
      'date': '13 يناير 2026',
      'time': '03:00 مساء',
      'icon': Icons.message_outlined,
      'iconBg': Color(0xFFE8F0FE),
      'iconColor': Color(0xFF3B82F6),
      'accentColor': Color(0xFF3B82F6),
    },
    {
      'title': 'تحديث هام',
      'isUnread': false,
      'subtitle': 'تم تأكيد استقدام العاملة المنزلية',
      'body':
          'نحن سعداء بإعلامك أن كافة الإجراءات تمت بنجاح، وستستلم العاملة خلال 3 أيام',
      'date': '15 يناير 2026',
      'time': '10:00 صباحاً',
      'icon': Icons.check_circle_outline,
      'iconBg': Color(0xFFE8F5F0),
      'iconColor': Color(0xFF2D6A4F),
      'accentColor': Color(0xFF2D6A4F),
    },
    {
      'title': 'نصيحة الأسبوع',
      'isUnread': false,
      'subtitle': 'كيف تختار أفضل عاملة منزلية؟',
      'body':
          'اكتشف أهم النصائح لاختيار العاملة المنزلية المناسبة لاحتياجاتك وميزانيتك',
      'date': '12 يناير 2026',
      'time': '09:00 صباحاً',
      'icon': Icons.lightbulb_outline,
      'iconBg': Color(0xFFFFF8E1),
      'iconColor': Color(0xFFF59E0B),
      'accentColor': Color(0xFFF59E0B),
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var n in _notifications) {
        n['isUnread'] = false;
      }
    });
  }

  void _markAsRead(int index) {
    setState(() => _notifications[index]['isUnread'] = false);
  }

  void _deleteNotification(int index) {
    setState(() => _notifications.removeAt(index));
  }

  int get _unreadCount =>
      _notifications.where((n) => n['isUnread'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(),

            // ── Notifications List ──
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: _notifications.length,
                      itemBuilder: (_, i) => _buildNotificationItem(i),
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
          // Mark all as read
          GestureDetector(
            onTap: _unreadCount > 0 ? _markAllAsRead : null,
            child: Text(
              'تحديد الكل كمقروء',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: _unreadCount > 0
                    ? const Color(0xFF2D6A4F)
                    : Colors.grey.shade400,
                decoration: TextDecoration.underline,
                decorationColor: _unreadCount > 0
                    ? const Color(0xFF2D6A4F)
                    : Colors.grey.shade400,
              ),
            ),
          ),

          const Spacer(),

          // Title with badge
          Row(
            children: [
              if (_unreadCount > 0) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '$_unreadCount',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
              ],
              Text(
                'الإشعارات',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2332),
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          // Back button
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
        ],
      ),
    );
  }

  // ── Notification Item ────────────────────────────────────
  Widget _buildNotificationItem(int index) {
    final n = _notifications[index];
    final isUnread = n['isUnread'] as bool;

    return Dismissible(
      key: Key('notification_$index'),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => _deleteNotification(index),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.w),
        color: const Color(0xFFE53935),
        child: Icon(Icons.delete_outline, color: Colors.white, size: 24.sp),
      ),
      child: GestureDetector(
        onTap: () {
          _markAsRead(index);
          _showNotificationDetail(n);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isUnread ? const Color(0xFFF0FDF4) : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isUnread
                  ? (n['accentColor'] as Color).withOpacity(0.2)
                  : Colors.grey.shade100,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Title + unread dot
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isUnread) ...[
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: n['accentColor'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                          ],
                          Flexible(
                            child: Text(
                              n['title'],
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14.sp,
                                fontWeight: isUnread
                                    ? FontWeight.w800
                                    : FontWeight.w700,
                                color: const Color(0xFF1A2332),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4.h),

                      // Subtitle
                      Text(
                        n['subtitle'],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.right,
                      ),

                      SizedBox(height: 4.h),

                      // Body
                      Text(
                        n['body'],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 8.h),

                      // Date & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            n['time'],
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            n['date'],
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11.sp,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // Icon
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: n['iconBg'] as Color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    n['icon'] as IconData,
                    color: n['iconColor'] as Color,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Notification Detail Bottom Sheet ────────────────────
  void _showNotificationDetail(Map<String, dynamic> n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Icon + Title
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  n['title'],
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1A2332),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: n['iconBg'] as Color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    n['icon'] as IconData,
                    color: n['iconColor'] as Color,
                    size: 22.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Subtitle
            Text(
              n['subtitle'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.right,
            ),

            SizedBox(height: 8.h),

            // Full body
            Text(
              n['body'],
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                color: Colors.grey.shade500,
                height: 1.6,
              ),
              textAlign: TextAlign.right,
            ),

            SizedBox(height: 12.h),

            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.access_time,
                  size: 14.sp,
                  color: Colors.grey.shade400,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${n['date']} - ${n['time']}',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Close button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'إغلاق',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  // ── Empty State ──────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A2332),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'ستظهر هنا جميع الإشعارات المتعلقة بطلباتك',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
