import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF00B894);
  static const Color primaryLight = Color(0xFF00CEC9);
  static const Color primaryDim = Color(0xFFE6F9F7);

  // Secondary
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFEF3C7);

  // Dark
  static const Color dark = Color(0xFF1A2332);
  static const Color mid = Color(0xFF4A5568);
  static const Color soft = Color(0xFF718096);

  // Background
  static const Color background = Color(0xFFF7FAFC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);

  // Status
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF1A2332), Color(0xFF2D3748)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
