import 'package:flutter/material.dart';
import 'package:meal_app/core/theme/app_colors.dart';


class CustomeCategoryButton extends StatelessWidget {
  const CustomeCategoryButton({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryDark : AppColors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.black,
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
