// lib/core/widgets/home_shimmer.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      body: Column(
        children: [
          // ── Header Shimmer ──
          _buildHeaderShimmer(),

          // ── Body Shimmer ──
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Banner shimmer
                  _buildBannerShimmer(),

                  SizedBox(height: 12.h),

                  // Dots shimmer
                  _buildDotsShimmer(),

                  SizedBox(height: 16.h),

                  // Search card shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildSearchCardShimmer(),
                  ),

                  SizedBox(height: 16.h),

                  // Track card shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: _buildTrackCardShimmer(),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom Nav Shimmer ──
          _buildBottomNavShimmer(),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────
  Widget _buildHeaderShimmer() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF1A3A2A),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFF2D6A4F),
            highlightColor: const Color(0xFF3D8A6F),
            child: Row(
              children: [
                // Bell shimmer
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(width: 12.w),

                // Text shimmer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 160.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 120.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // Logo shimmer
                Container(
                  width: 52.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Banner ──────────────────────────────────────────────
  Widget _buildBannerShimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: double.infinity,
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  // ── Dots ────────────────────────────────────────────────
  Widget _buildDotsShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: i == 0 ? 20.w : 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3.r),
            ),
          );
        }),
      ),
    );
  }

  // ── Search Card ─────────────────────────────────────────
  Widget _buildSearchCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFF2D6A4F).withOpacity(0.2)),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Hint text shimmer
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _shimmerLine(width: double.infinity, height: 10.h),
                      SizedBox(height: 6.h),
                      _shimmerLine(width: 200.w, height: 10.h),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Divider(height: 1, color: Colors.grey.shade200),
            SizedBox(height: 16.h),

            // Dropdown items shimmer
            ...List.generate(4, (i) {
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _shimmerLine(width: 80.w, height: 10.h),
                            SizedBox(height: 4.h),
                            _shimmerLine(width: 160.w, height: 10.h),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                  if (i < 3) ...[
                    SizedBox(height: 14.h),
                    Divider(height: 1, color: Colors.grey.shade200),
                    SizedBox(height: 14.h),
                  ],
                ],
              );
            }),

            SizedBox(height: 16.h),

            // Button shimmer
            Container(
              width: double.infinity,
              height: 52.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D6A4F).withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Track Card ──────────────────────────────────────────
  Widget _buildTrackCardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _shimmerLine(width: 120.w, height: 12.h),
                      SizedBox(height: 8.h),
                      _shimmerLine(width: double.infinity, height: 10.h),
                      SizedBox(height: 4.h),
                      _shimmerLine(width: 160.w, height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Container(
                  width: 100.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom Nav ──────────────────────────────────────────
  Widget _buildBottomNavShimmer() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 26.w,
                      height: 26.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _shimmerLine(width: 40.w, height: 8.h),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  // ── Helper ───────────────────────────────────────────────
  Widget _shimmerLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
