import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              ],
            ),
          ),
        )
    );
  }
}
