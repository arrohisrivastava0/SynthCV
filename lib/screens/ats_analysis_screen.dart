import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synthcv/widget/ats_chart_section.dart';

class ATSAnalysisScreen extends StatelessWidget {
  final int atsScore;
  final double matchPercentage;
  final String hiringProbability;
  final List<String> suggestions;
  final VoidCallback onRegenerateResume;

  const ATSAnalysisScreen({
    super.key,
    required this.atsScore,
    required this.matchPercentage,
    required this.hiringProbability,
    required this.suggestions,
    required this.onRegenerateResume,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ATS Analysis"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF121212),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScoreTile("ATS Score", "$atsScore%", Colors.cyanAccent),
              _buildScoreTile("Match Percentage", "$matchPercentage%", Colors.orangeAccent),
              _buildScoreTile("Hiring Probability", hiringProbability, Colors.purpleAccent),
              const SizedBox(height: 24),
              Text(
                "Suggestions to Improve:",
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  shadows: [const Shadow(blurRadius: 6, color: Colors.cyanAccent)],
                ),
              ),
              const SizedBox(height: 10),
              ...suggestions.map((s) => Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.tips_and_updates, color: Colors.greenAccent, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        s,
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 30),
              ATSChartSection(atsScore: atsScore, matchPercentage: matchPercentage),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRegenerateResume,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text("Regenerate Resume"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    side: const BorderSide(color: Colors.cyanAccent),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // body: Container(
      //   width: double.infinity,
      //   padding: const EdgeInsets.all(20),
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       _buildScoreTile("ATS Score", "$atsScore%", Colors.cyanAccent),
      //       _buildScoreTile("Match Percentage", "$matchPercentage%", Colors.orangeAccent),
      //       _buildScoreTile("Hiring Probability", hiringProbability, Colors.purpleAccent),
      //       const SizedBox(height: 24),
      //
      //       Text("Suggestions to Improve:",
      //         style: GoogleFonts.orbitron(
      //           fontSize: 16,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.cyanAccent,
      //           shadows: [const Shadow(blurRadius: 6, color: Colors.cyanAccent)],
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //
      //       ...suggestions.map((s) => Container(
      //         margin: const EdgeInsets.symmetric(vertical: 6),
      //         padding: const EdgeInsets.all(12),
      //         decoration: BoxDecoration(
      //           color: Colors.white.withOpacity(0.04),
      //           borderRadius: BorderRadius.circular(12),
      //           border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
      //         ),
      //         child: Row(
      //           children: [
      //             const Icon(Icons.tips_and_updates, color: Colors.greenAccent, size: 20),
      //             const SizedBox(width: 10),
      //             Expanded(
      //               child: Text(s,
      //                 style: GoogleFonts.rubik(
      //                   color: Colors.white,
      //                   fontSize: 14,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       )),
      //
      //       const SizedBox(height: 30),
      //       ATSChartSection(atsScore: atsScore, matchPercentage: matchPercentage),
      //       const SizedBox(height: 30),
      //
      //       SizedBox(
      //         width: double.infinity,
      //         child: ElevatedButton.icon(
      //           onPressed: onRegenerateResume,
      //           icon: const Icon(Icons.refresh, color: Colors.white),
      //           label: const Text("Regenerate Resume"),
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.cyanAccent.withOpacity(0.2),
      //             foregroundColor: Colors.white,
      //             elevation: 8,
      //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //             side: const BorderSide(color: Colors.cyanAccent),
      //             padding: const EdgeInsets.symmetric(vertical: 16),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildScoreTile(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.rubik(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
