import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonIconButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  // final Color borderColor;
  final Color glowColor;
  final bool isDisabled;

  const NeonIconButton({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
    // required this.borderColor,
    required this.glowColor,
    this.isLoading = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: (isLoading || isDisabled) ? null : onPressed,
      icon: icon != null ? Icon(icon, color: glowColor) : const SizedBox.shrink(),
      label: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2),
            )
          : Text(
              label,
              //style: const TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //         ),
            ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        backgroundColor: glowColor.withOpacity(0.15),
        foregroundColor: Colors.white,
        // backgroundColor: Colors.transparent,
        shadowColor: glowColor,
        textStyle: GoogleFonts.orbitron(fontWeight: FontWeight.w600),
        elevation: 10,
        // side: BorderSide(color: borderColor),
        side: BorderSide(color: glowColor.withOpacity(0.7)),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
