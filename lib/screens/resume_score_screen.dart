import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synthcv/widget/ats_analysis_widgets/visual_score.dart';

class ResumeScoreScreen extends StatelessWidget {
  final Map<String, dynamic>? score;

  const ResumeScoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final double resumeScore = score?['resume_score'] ?? 0.0;
    final List strengths = score?['strengths'] ?? [];
    final List areasOfImprovement = score?['areas_of_improvement'] ?? [];
    final String overallSummary = score?['overall_summary'] ?? " ";
    final List<String> keyRecommendations =
        score?['key_recommendations'].cast<String>() ?? [];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFF121212),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF121212), // deep dark base
                Color(0xFF1A1B2F), // subtle bluish tone
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VisualScoreRow(
                  label: "Resume Score",
                  percent: resumeScore,
                  color: const Color(0xFFC251D7),
                ),
                const SizedBox(height: 24),
                // Add this after your last score row and before the "Summary of Suggestions"
                Text(
                  "Analysis Summary:",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                    shadows: [
                      const Shadow(blurRadius: 6, color: Colors.purpleAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purpleAccent.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.insights, color: Colors.purpleAccent, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          overallSummary,
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
