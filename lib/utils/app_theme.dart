import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4F46E5); // Indigo
  static const background = Color(0xFFF5F7FA);
  static const card = Colors.white;
  static const textPrimary = Colors.black;
  static const textSecondary = Colors.grey;

  static const success = Colors.green;
  static const danger = Colors.red;
}

class AppTextStyles {
  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );

  static const amount = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.danger,
  );

  static const appbarTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

class AppDimens {
  static const padding = 12.0;
  static const radius = 16.0;
}

class AppInput {
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey.shade300),
  );
}
