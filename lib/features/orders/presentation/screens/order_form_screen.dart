// lib/features/orders/presentation/screens/order_form_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({super.key});

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  int _currentStep = 0; // 0, 1, 2

  // Step 1 - Customer Details
  final _nameController = TextEditingController(text: 'Ahmed Mohamed Gamal');
  final _phoneController = TextEditingController(text: '501234567');
  final _emailController = TextEditingController(text: 'ahmedhoss12@gmail.com');
  String _selectedCity = 'الرياض';
  String _selectedCountryCode = '+966';
  String _selectedFlag = '🇸🇦';
  final _step1Key = GlobalKey<FormState>();

  // Step 2 - Order Details
  String _selectedLaborType = '';
  String _selectedNationality = '';
  String _selectedPackage = '';
  final _countController = TextEditingController(text: '1');
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  final _step2Key = GlobalKey<FormState>();

  // Step 3 - Schedule Details
  DateTime? _scheduleFrom;
  DateTime? _scheduleTo;
  String _selectedArrivalTime = '';
  final _notesController = TextEditingController();
  final _step3Key = GlobalKey<FormState>();

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
  ];

  final List<Map<String, String>> _countries = [
    {'code': '+966', 'flag': '🇸🇦', 'name': 'السعودية'},
    {'code': '+20', 'flag': '🇪🇬', 'name': 'مصر'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'الإمارات'},
    {'code': '+965', 'flag': '🇰🇼', 'name': 'الكويت'},
  ];

  final List<String> _laborTypes = ['فردي', 'مجموعة'];
  final List<String> _nationalities = [
    'مصر',
    'اثيوبيا',
    'اوغندا',
    'كينيا',
    'الفلبين',
    'سريلانكا',
    'الهند',
    'باكستان',
    'بنغلاديش',
  ];
  final List<String> _packages = [
    'بالساعة',
    'أسبوع (7 أيام)',
    'أسبوعان (15 يوم)',
    'شهر (30 يوم)',
    '60 يوم',
    '180 يوم',
    '360 يوم',
  ];
  final List<String> _arrivalTimes = ['صباحاً', 'مساءً'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _countController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _next() {
    bool valid = false;
    if (_currentStep == 0) valid = _step1Key.currentState!.validate();
    if (_currentStep == 1) valid = _step2Key.currentState!.validate();
    if (_currentStep == 2) valid = _step3Key.currentState!.validate();

    if (valid) {
      if (_currentStep < 2) {
        setState(() => _currentStep++);
      } else {
        _submitOrder();
      }
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  void _submitOrder() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF2D6A4F), size: 60),
            SizedBox(height: 16.h),
            Text(
              'تم إرسال طلبك بنجاح!',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A2332),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'سيتواصل معك مندوب الشركة قريباً',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (_) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'الرئيسية',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──
            _buildAppBar(),

            // ── Step Indicator ──
            _buildStepIndicator(),

            // ── Step Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    if (_currentStep == 0) _buildStep1(),
                    if (_currentStep == 1) _buildStep2(),
                    if (_currentStep == 2) _buildStep3(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),

            // ── Next Button ──
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  // ── App Bar ─────────────────────────────────────────────
  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _back,
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
                'طلب عمالة',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2332),
                ),
              ),
              Text(
                'من فضلك ادخل البيانات لاستكمال طلبك',
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
    );
  }

  // ── Step Indicator ──────────────────────────────────────
  Widget _buildStepIndicator() {
    final steps = ['بيانات العميل', 'تفاصيل الطلب', 'تفاصيل الجدولة'];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: List.generate(steps.length, (i) {
          final isActive = i == _currentStep;
          final isDone = i < _currentStep;
          final isLast = i == steps.length - 1;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // Circle
                      Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive || isDone
                              ? const Color(0xFF2D6A4F)
                              : Colors.grey.shade200,
                          border: isActive
                              ? Border.all(
                                  color: const Color(
                                    0xFF2D6A4F,
                                  ).withOpacity(0.3),
                                  width: 3,
                                )
                              : null,
                        ),
                        child: Center(
                          child: isDone
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14.sp,
                                )
                              : Text(
                                  '${i + 1}',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w800,
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Label
                      Text(
                        steps[i],
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 10.sp,
                          fontWeight: isActive
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isActive
                              ? const Color(0xFF2D6A4F)
                              : Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Line connector
                if (!isLast)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      margin: EdgeInsets.only(bottom: 16.h),
                      color: i < _currentStep
                          ? const Color(0xFF2D6A4F)
                          : Colors.grey.shade200,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ── Step 1 - Customer Details ────────────────────────────
  Widget _buildStep1() {
    return Form(
      key: _step1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLabel('اسم العميل'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _nameController,
            hint: 'Ahmed Mohamed Gamal',
            validator: (v) => v!.isEmpty ? 'الاسم مطلوب' : null,
          ),

          SizedBox(height: 16.h),

          _buildLabel('رقم الجوال'),
          SizedBox(height: 8.h),
          _buildPhoneField(),

          SizedBox(height: 16.h),

          _buildLabel('البريد الإلكتروني'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _emailController,
            hint: 'ahmedhoss12@gmail.com',
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v!.isEmpty) return 'البريد مطلوب';
              if (!v.contains('@')) return 'بريد غير صحيح';
              return null;
            },
          ),

          SizedBox(height: 16.h),

          _buildLabel('المدينة'),
          SizedBox(height: 8.h),
          _buildPickerField(
            value: _selectedCity,
            hint: 'اختر المدينة',
            onTap: () => _showPicker(
              'اختر المدينة',
              _cities,
              (v) => setState(() => _selectedCity = v),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step 2 - Order Details ───────────────────────────────
  Widget _buildStep2() {
    return Form(
      key: _step2Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLabel('نوع العمالة'),
          SizedBox(height: 8.h),
          _buildPickerField(
            value: _selectedLaborType,
            hint: 'اختر نوع العمالة',
            onTap: () => _showPicker(
              'نوع العمالة',
              _laborTypes,
              (v) => setState(() => _selectedLaborType = v),
            ),
            validator: (v) =>
                _selectedLaborType.isEmpty ? 'نوع العمالة مطلوب' : null,
          ),

          SizedBox(height: 16.h),

          _buildLabel('الجنسية المطلوبة'),
          SizedBox(height: 8.h),
          _buildPickerField(
            value: _selectedNationality,
            hint: 'اختر الجنسية',
            onTap: () => _showPicker(
              'الجنسية المطلوبة',
              _nationalities,
              (v) => setState(() => _selectedNationality = v),
            ),
          ),

          SizedBox(height: 16.h),

          _buildLabel('عدد العمالة المطلوبة'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _countController,
            hint: '1',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),

          SizedBox(height: 16.h),

          _buildLabel('مدة العمل (بالأيام)'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _durationController,
            hint: 'أدخل عدد الأيام',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),

          SizedBox(height: 16.h),

          _buildLabel('اختر الباقة'),
          SizedBox(height: 8.h),
          _buildPickerField(
            value: _selectedPackage,
            hint: 'اختر الباقة',
            onTap: () => _showPicker(
              'اختر الباقة',
              _packages,
              (v) => setState(() => _selectedPackage = v),
            ),
            validator: (v) => _selectedPackage.isEmpty ? 'الباقة مطلوبة' : null,
          ),

          SizedBox(height: 16.h),

          _buildLabel('السعر شامل الضريبة'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _priceController,
            hint: '0.00',
            keyboardType: TextInputType.number,
            readOnly: true,
            suffixText: 'ريال',
          ),
        ],
      ),
    );
  }

  // ── Step 3 - Schedule Details ────────────────────────────
  Widget _buildStep3() {
    return Form(
      key: _step3Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildLabel('من'),
          SizedBox(height: 8.h),
          _buildDateField(
            value: _scheduleFrom != null
                ? '${_scheduleFrom!.year}/${_scheduleFrom!.month}/${_scheduleFrom!.day}'
                : '',
            hint: 'اختر تاريخ البداية',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) setState(() => _scheduleFrom = date);
            },
          ),

          SizedBox(height: 16.h),

          _buildLabel('إلى'),
          SizedBox(height: 8.h),
          _buildDateField(
            value: _scheduleTo != null
                ? '${_scheduleTo!.year}/${_scheduleTo!.month}/${_scheduleTo!.day}'
                : '',
            hint: 'اختر تاريخ الانتهاء',
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _scheduleFrom ?? DateTime.now(),
                firstDate: _scheduleFrom ?? DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) setState(() => _scheduleTo = date);
            },
          ),

          SizedBox(height: 16.h),

          _buildLabel('وقت الوصول'),
          SizedBox(height: 8.h),
          Row(
            children: _arrivalTimes.map((time) {
              final isSelected = _selectedArrivalTime == time;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedArrivalTime = time),
                  child: Container(
                    margin: EdgeInsets.only(left: time == 'صباحاً' ? 8.w : 0),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2D6A4F)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF2D6A4F)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        time,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 16.h),

          _buildLabel('ملاحظات إضافية'),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextFormField(
              controller: _notesController,
              maxLines: 4,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: const Color(0xFF1A2332),
              ),
              decoration: InputDecoration(
                hintText: 'أي ملاحظات إضافية...',
                hintStyle: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13.sp,
                  color: Colors.grey.shade400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Next Button ─────────────────────────────────────────
  Widget _buildNextButton() {
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
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: _next,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D6A4F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            elevation: 0,
          ),
          child: Text(
            _currentStep == 2 ? 'إرسال الطلب' : 'التالي',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────
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
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool readOnly = false,
    String? suffixText,
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
        readOnly: readOnly,
        inputFormatters: inputFormatters,
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
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13.sp,
            color: Colors.grey.shade500,
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
              ),
              validator: (v) => v!.isEmpty ? 'رقم الجوال مطلوب' : null,
            ),
          ),
          Container(width: 1, height: 30.h, color: Colors.grey.shade300),
          GestureDetector(
            onTap: () => _showCountryPicker(),
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

  Widget _buildPickerField({
    required String value,
    required String hint,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: FormField<String>(
        validator: validator,
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 54.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: state.hasError
                      ? const Color(0xFFE53935)
                      : Colors.grey.shade300,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20.sp,
                    color: Colors.grey.shade500,
                  ),
                  const Spacer(),
                  Text(
                    value.isEmpty ? hint : value,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14.sp,
                      color: value.isEmpty
                          ? Colors.grey.shade400
                          : const Color(0xFF1A2332),
                    ),
                  ),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 8.w),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    color: const Color(0xFFE53935),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String value,
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
              Icons.calendar_today_outlined,
              size: 20.sp,
              color: Colors.grey.shade500,
            ),
            const Spacer(),
            Text(
              value.isEmpty ? hint : value,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.sp,
                color: value.isEmpty
                    ? Colors.grey.shade400
                    : const Color(0xFF1A2332),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              children: options
                  .map(
                    (o) => ListTile(
                      title: Text(
                        o,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp),
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        onSelect(o);
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
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
        children: _countries
            .map(
              (c) => ListTile(
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
              ),
            )
            .toList(),
      ),
    );
  }
}
