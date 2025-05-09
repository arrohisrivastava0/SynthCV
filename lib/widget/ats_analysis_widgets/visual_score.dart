// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class VisualScoreRow extends StatelessWidget {
//   final String label;
//   final double percent; // 0.0 to 1.0
//   final Color color;
//   final bool reverse;
//
//   const VisualScoreRow({
//     super.key,
//     required this.label,
//     required this.percent,
//     required this.color,
//     this.reverse = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final circle = CircularPercentIndicator(
//       radius: 50.0,
//       lineWidth: 8.0,
//       percent: percent,
//       center: Text("${(percent * 100).toInt()}%", style: GoogleFonts.rubik(color: Colors.white)),
//       progressColor: color,
//       backgroundColor: Colors.white10,
//       circularStrokeCap: CircularStrokeCap.round,
//     );
//
//     final labelWidget = Text(
//       label,
//       style: GoogleFonts.orbitron(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//     );
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: reverse
//             ? [circle, labelWidget]
//             : [labelWidget, circle],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class VisualScoreRow extends StatefulWidget {
//   final String label;
//   final double percent; // 0.0 to 1.0
//   final Color color;
//   final bool reverse;
//
//   const VisualScoreRow({
//     super.key,
//     required this.label,
//     required this.percent,
//     required this.color,
//     this.reverse = false,
//   });
//
//   @override
//   State<VisualScoreRow> createState() => _VisualScoreRowState();
// }
//
// class _VisualScoreRowState extends State<VisualScoreRow> with SingleTickerProviderStateMixin {
//   double _animatedPercent = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _animateTo(widget.percent);
//   }
//
//   @override
//   void didUpdateWidget(covariant VisualScoreRow oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.percent != oldWidget.percent) {
//       _animateTo(widget.percent);
//     }
//   }
//
//   void _animateTo(double target) {
//     Future.delayed(Duration.zero, () {
//       setState(() => _animatedPercent = target);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final glowingCircle = Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: widget.color.withOpacity(0.6),
//             blurRadius: 20,
//             spreadRadius: 3,
//           ),
//         ],
//       ),
//       child: CircularPercentIndicator(
//         animation: true,
//         animationDuration: 2000,
//         radius: 50.0,
//         lineWidth: 8.0,
//         percent: _animatedPercent.clamp(0.0, 1.0),
//         center: Text(
//           "${(_animatedPercent * 100).toInt()}%",
//           style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         progressColor: widget.color,
//         backgroundColor: Colors.white10,
//         circularStrokeCap: CircularStrokeCap.round,
//       ),
//     );
//
//     final labelWidget = Text(
//       widget.label,
//       style: GoogleFonts.orbitron(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//         shadows: [Shadow(color: widget.color, blurRadius: 4)],
//       ),
//     );
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: widget.reverse
//             ? [glowingCircle, labelWidget]
//             : [labelWidget, glowingCircle],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VisualScoreRow extends StatefulWidget {
  final String label;
  final double percent; // 0.0 to 1.0
  final Color color;
  final bool reverse;

  const VisualScoreRow({
    super.key,
    required this.label,
    required this.percent,
    required this.color,
    this.reverse = false,
  });

  @override
  State<VisualScoreRow> createState() => _VisualScoreRowState();
}

class _VisualScoreRowState extends State<VisualScoreRow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _percentAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _percentAnim = Tween<double>(begin: 0.0, end: widget.percent).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _glowAnim = Tween<double>(begin: 5.0, end: 18.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant VisualScoreRow oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _percentAnim = Tween<double>(begin: 0.0, end: widget.percent).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ));
      _controller.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCircle(double percent, double glow) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.5),
            blurRadius: glow,
            spreadRadius: 1.5,
          ),
        ],
      ),
      child: CircularPercentIndicator(
        animation: false,
        radius: 50.0,
        lineWidth: 8.0,
        percent: percent.clamp(0.0, 1.0),
        center: Text(
          "${(percent * 100).toInt()}%",
          style: GoogleFonts.rubik(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        progressColor: widget.color,
        backgroundColor: Colors.white10,
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final label = Text(
      widget.label,
      style: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final animatedPercent = _percentAnim.value;
          final animatedGlow = _glowAnim.value;

          final circle = _buildCircle(animatedPercent, animatedGlow);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.reverse ? [circle, label] : [label, circle],
          );
        },
      ),
    );
  }
}

