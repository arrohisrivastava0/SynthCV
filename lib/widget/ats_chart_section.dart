import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ATSChartSection extends StatelessWidget {
  final int atsScore;
  final double matchPercentage;

  const ATSChartSection({
    super.key,
    required this.atsScore,
    required this.matchPercentage,
  });

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Visual Analysis",
            style: GoogleFonts.orbitron(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
              shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
            ),
          ),
          const SizedBox(height: 20),

          // ✅ Give PieChart a fixed height using SizedBox
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40,
                sectionsSpace: 4,
                sections: [
                  PieChartSectionData(
                    value: atsScore.toDouble(),
                    color: Colors.cyanAccent,
                    title: 'ATS\n${atsScore.toInt()}%',
                    radius: 65,
                    titleStyle: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: matchPercentage,
                    color: Colors.orangeAccent,
                    title: 'Match\n${matchPercentage.toInt()}%',
                    radius: 65,
                    titleStyle: GoogleFonts.rubik(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.all(20),
  //     margin: const EdgeInsets.only(top: 20),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.04),
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.cyanAccent.withOpacity(0.1),
  //           blurRadius: 12,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           "Visual Analysis",
  //           style: GoogleFonts.orbitron(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.cyanAccent,
  //             shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         PieChart(
  //           PieChartData(
  //             centerSpaceRadius: 40,
  //             sectionsSpace: 4,
  //             sections: [
  //               PieChartSectionData(
  //                 value: atsScore.toDouble(),
  //                 color: Colors.cyanAccent,
  //                 title: 'ATS\n${atsScore.toInt()}%',
  //                 radius: 65,
  //                 titleStyle: GoogleFonts.rubik(
  //                   color: Colors.black,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 // badgeWidget: _glowDot(Colors.cyanAccent),
  //                 // badgePositionPercentageOffset: 1.2,
  //               ),
  //               PieChartSectionData(
  //                 value: matchPercentage,
  //                 color: Colors.orangeAccent,
  //                 title: 'Match\n${matchPercentage.toInt()}%',
  //                 radius: 65,
  //                 titleStyle: GoogleFonts.rubik(
  //                   color: Colors.black,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 // badgeWidget: _glowDot(Colors.orangeAccent),
  //                 // badgePositionPercentageOffset: 1.2,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _glowDot(Color color) {
    return SizedBox(
      width: 16,
      height: 16,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
