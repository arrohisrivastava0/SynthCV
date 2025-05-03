import 'package:flutter/material.dart';

Widget buildInputField({
  IconData? icon,
  required String hint,
  required TextEditingController controller,
  int? maxLines =1,
  bool obscureText = false,
  IconData? suffixIcon,
  VoidCallback? onSuffixTap,

}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextField(
      maxLines: maxLines,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Icon(suffixIcon, color: Colors.white),
        )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
