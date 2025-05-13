import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synthcv/widget/ats_analysis_widgets/visual_score.dart';

class ResumeScoreScreen extends StatelessWidget {
  final Map<String, dynamic>? score;

  const ResumeScoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final double resumeScore = score?['resume_score'] ?? 77.6;
    final List strengths = score?['strengths'] ??
        [
          {
            "area": 'hehe',
            "comment": 'hello niggas how are you ifne sankyu',
            "score_impact": '+10'
          }
        ];
    final List areasOfImprovement = score?['areas_of_improvement'] ??
        [
          {
            "area": 'hehe',
            "comment": 'hello niggas how are you ifne sankyu',
            "score_impact": '-9'
          }
        ];
    final String overallSummary = score?['overall_summary'] ??
        "Your resume demonstrates a strong technical foundation for this Flutter Development internship. You clearly showcase experience with key required skills like Flutter, Firebase, Dart, REST API, and MVC through your projects and skills list. Your project work is directly relevant. To elevate your application further, you'll want to more explicitly align your resume with the 'Other Requirements' of the role, particularly by highlighting your interest in startups and your passion for Flutter development.";
    final List<String> keyRecommendations = score?['key_recommendations'] ??
        [
          "Add a resume summary mentioning 'startup interest', 'passion for Flutter', 'clean code'.",
          "Use cover letter to explicitly confirm all eligibility (dates, WFH, duration) and 'other requirements'.",
          "Subtly add phrases for 'ownership' or 'learning' in project details.",
          "Ensure 'Mobile Application Development' is clear in skills."
        ];

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
                  percent: resumeScore / 100,
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
                    border:
                        Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
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
                      const Icon(Icons.insights,
                          color: Colors.purpleAccent, size: 20),
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
                const SizedBox(height: 24),
                Text(
                  "Strengths:",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent,
                    shadows: [
                      const Shadow(blurRadius: 6, color: Colors.greenAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ...strengths.map((item) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.greenAccent, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['area'] ?? '',
                                      style: GoogleFonts.rubik(
                                        color: Colors.greenAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      item['score_impact'] ?? '',
                                      style: GoogleFonts.rubik(
                                        color: (item['score_impact'][0] == '+')
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['comment'] ?? '',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 24),
                Text(
                  "Areas of Improvement:",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    shadows: [
                      const Shadow(blurRadius: 6, color: Colors.redAccent),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ...areasOfImprovement.map((item) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.redAccent.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.redAccent, size: 18),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['area'] ?? '',
                                      style: GoogleFonts.rubik(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      item['score_impact'] ?? '',
                                      style: GoogleFonts.rubik(
                                        color: (item['score_impact'][0] == '+')
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['comment'] ?? '',
                                  style: GoogleFonts.rubik(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 24),
                Text(
                  "Suggestions to Improve:",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                    shadows: [
                      const Shadow(blurRadius: 6, color: Colors.cyanAccent)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...keyRecommendations.map((s) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.tips_and_updates,
                              color: Colors.greenAccent, size: 20),
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
              ],
            ),
          ),
        ));
  }
}
