// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// //
// // class HiringProbabilityBar extends StatelessWidget {
// //   final String probabilityLevel; // e.g. "Excellent", "Good", etc.
// //
// //   HiringProbabilityBar({super.key, required this.probabilityLevel});
// //
// //   final List<String> levels = ['Low', 'Fair', 'Good', 'Strong', 'Excellent'];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int index = levels.indexOf(probabilityLevel);
// //     index = index < 0 ? 0 : index;
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           "Hiring Probability",
// //           style: GoogleFonts.orbitron(
// //             fontSize: 16,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.cyanAccent,
// //             shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         Row(
// //           children: List.generate(levels.length, (i) {
// //             final isActive = i <= index;
// //             return Expanded(
// //               child: Container(
// //                 height: 14,
// //                 margin: EdgeInsets.only(right: i == levels.length - 1 ? 0 : 4),
// //                 decoration: BoxDecoration(
// //                   color: isActive ? _getColorForIndex(i).withOpacity(0.8) : Colors.white12,
// //                   borderRadius: BorderRadius.circular(8),
// //                   boxShadow: isActive
// //                       ? [
// //                     BoxShadow(
// //                       color: _getColorForIndex(i).withOpacity(0.5),
// //                       blurRadius: 6,
// //                       spreadRadius: 1,
// //                     )
// //                   ]
// //                       : [],
// //                 ),
// //               ),
// //             );
// //           }),
// //         ),
// //         const SizedBox(height: 10),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: levels
// //               .map((label) => Text(label,
// //               style: GoogleFonts.rubik(fontSize: 12, color: Colors.white54)))
// //               .toList(),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Color _getColorForIndex(int i) {
// //     switch (i) {
// //       case 0:
// //         return Colors.redAccent;
// //       case 1:
// //         return Colors.orangeAccent;
// //       case 2:
// //         return Colors.yellowAccent;
// //       case 3:
// //         return Colors.lightGreenAccent;
// //       case 4:
// //         return Colors.cyanAccent;
// //       default:
// //         return Colors.grey;
// //     }
// //   }
// // }
//
// class HiringProbabilityBar extends StatelessWidget {
//   final String probabilityLevel; // e.g. "Excellent", "Good", etc.
//
//   HiringProbabilityBar({super.key, required this.probabilityLevel});
//
//   final List<String> levels = ['Low', 'Fair', 'Good', 'Strong', 'Excellent'];
//
//   @override
//   Widget build(BuildContext context) {
//     int index = levels.indexOf(probabilityLevel);
//     index = index < 0 ? 0 : index;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Hiring Probability: ",
//               style: GoogleFonts.orbitron(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.cyanAccent,
//                 shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
//               ),
//             ),
//             const SizedBox(width: 2),
//             Text(
//               probabilityLevel,
//               style: GoogleFonts.rubik(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: _getColorForIndex(index),
//                 shadows: [
//                   Shadow(
//                     color: _getColorForIndex(index).withOpacity(0.7),
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: List.generate(levels.length, (i) {
//             final isActive = i <= index;
//             return Expanded(
//               child: Container(
//                 height: 14,
//                 margin: EdgeInsets.only(right: i == levels.length - 1 ? 0 : 4),
//                 decoration: BoxDecoration(
//                   color: isActive ? _getColorForIndex(i).withOpacity(0.8) : Colors.white12,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: isActive
//                       ? [
//                     BoxShadow(
//                       color: _getColorForIndex(i).withOpacity(0.5),
//                       blurRadius: 6,
//                       spreadRadius: 1,
//                     )
//                   ]
//                       : [],
//                 ),
//               ),
//             );
//           }),
//         ),
//
//         const SizedBox(height: 10),
//
//         Row(
//           children: [
//             Text(
//               "Hiring Probability",
//               style: GoogleFonts.orbitron(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.cyanAccent,
//                 shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
//               ),
//             ),
//             const SizedBox(width: 6),
//             Tooltip(
//               message:
//               "Low: Very unlikely\nFair: Slight chance\nGood: Possible\nStrong: Likely\nExcellent: Highly likely",
//               textStyle: GoogleFonts.rubik(color: Colors.white),
//               decoration: BoxDecoration(
//                 color: Colors.black87,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.info_outline, color: Colors.white60, size: 16),
//             ),
//           ],
//         ),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: levels
//               .map((label) => Text(label,
//               style: GoogleFonts.rubik(fontSize: 12, color: Colors.white54)))
//               .toList(),
//         ),
//       ],
//     );
//   }
//
//   Color _getColorForIndex(int i) {
//     switch (i) {
//       case 0:
//         return Colors.redAccent;
//       case 1:
//         return Colors.orangeAccent;
//       case 2:
//         return Colors.yellowAccent;
//       case 3:
//         return Colors.lightGreenAccent;
//       case 4:
//         return Colors.cyanAccent;
//       default:
//         return Colors.grey;
//     }
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HiringProbabilityBar extends StatelessWidget {
  final String probabilityLevel; // e.g. "Excellent", "Good", etc.

  HiringProbabilityBar({super.key, required this.probabilityLevel});

  final List<String> levels = ['Low', 'Fair', 'Good', 'Strong', 'Excellent'];

  @override
  Widget build(BuildContext context) {
    int index = levels.indexOf(probabilityLevel);
    index = index < 0 ? 0 : index;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hiring Probability",
              style: GoogleFonts.orbitron(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
              ),
            ),
            const SizedBox(width: 6),
            Tooltip(
              message: _getTooltipMessage(probabilityLevel),
              textStyle: GoogleFonts.rubik(color: Colors.white),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.info_outline, color: Colors.white60, size: 16),
            ),

            // Tooltip(
            //   message: "Low: Very unlikely\nFair: Slight chance\nGood: Possible\nStrong: Likely\nExcellent: Highly likely",
            //   textStyle: GoogleFonts.rubik(color: Colors.white),
            //   decoration: BoxDecoration(
            //     color: Colors.black87,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: const Icon(Icons.info_outline, color: Colors.white60, size: 16),
            // ),
            const SizedBox(width: 10),
            Text(
              probabilityLevel,
              style: GoogleFonts.rubik(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _getColorForIndex(index),
                shadows: [
                  Shadow(
                    color: _getColorForIndex(index).withOpacity(0.7),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: List.generate(levels.length, (i) {
            final isActive = i <= index;
            return Expanded(
              child: Container(
                height: 14,
                margin: EdgeInsets.only(right: i == levels.length - 1 ? 0 : 4),
                decoration: BoxDecoration(
                  color: isActive ? _getColorForIndex(i).withOpacity(0.85) : Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: _getColorForIndex(i).withOpacity(0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                  ]
                      : [],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: levels
              .map((label) => Text(
            label,
            style: GoogleFonts.rubik(fontSize: 12, color: Colors.white60),
          ))
              .toList(),
        ),
      ],
    );
  }

  Color _getColorForIndex(int i) {
    switch (i) {
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.deepOrangeAccent;
      case 2:
        return Colors.amberAccent;
      case 3:
        return Colors.lightGreenAccent;
      case 4:
        return Colors.cyanAccent;
      default:
        return Colors.grey;
    }
  }

  String _getTooltipMessage(String level) {
    switch (level) {
      case 'Low':
        return 'Your resume currently\nmatches very few job requirements.\nSignificant updates are recommended.';
      case 'Fair':
        return 'You meet some basic expectations,\nbut key skills or experiences are missing.';
      case 'Good':
        return 'A solid foundation!\nSome focused edits could\nimprove your chances further.';
      case 'Strong':
        return 'You’re a strong match for the job.\nA few refinements can push it to excellent.';
      case 'Excellent':
        return 'Excellent alignment!\nYou have a high chance of\nprogressing in the hiring process.';
      default:
        return 'No assessment available.';
    }
  }

}

