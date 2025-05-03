import 'package:flutter/material.dart';

class NeonIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color borderColor;
  final Color glowColor;
  final bool isDisabled;

  const NeonIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.borderColor,
    required this.glowColor,
    this.isLoading = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      icon: Icon(icon, color: Colors.white),
      label: isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
      )
          : Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: glowColor,
        elevation: 10,
        side: BorderSide(color: borderColor),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
