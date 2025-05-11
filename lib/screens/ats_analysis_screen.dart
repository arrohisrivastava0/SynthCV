import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synthcv/widget/ats_analysis_widgets/hiring_prob_bar.dart';
import 'package:synthcv/widget/ats_analysis_widgets/visual_score.dart';
// import 'package:synthcv/widget/ats_chart_section.dart';

class ATSAnalysis extends StatelessWidget {
  // final String atsId;
  final Map<String, dynamic>? score;

  const ATSAnalysis({
    super.key,
    // required this.atsId,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final double atsScore = score?['ats_score'] ?? 0.0;
    final double matchPer = score?['match_percentage'] ?? 0.0;
    final List suggestions = score?['suggestions'] ?? [];
    final String analysisSummary = score?['analysis_summary'] ?? "";
    final List<String> matchingSkills = score?['matching_skills'].cast<String>() ?? [];
    final List<String> missingSkills = score?['missing_skills'].cast<String>() ?? [];
    final List keySuggestions = score?['key_suggestions']??[];
    final String hiringProbability = score?['hiring_probability']??"";
    final parsedSummaries = parseSuggestionSummary(suggestions);
    // final String analysisSummary = "Your resume demonstrates a strong technical foundation for this Flutter Development internship. You clearly showcase experience with key required skills like Flutter, Firebase, Dart, REST API, and MVC through your projects and skills list. Your project work is directly relevant. To elevate your application further, you'll want to more explicitly align your resume with the 'Other Requirements' of the role, particularly by highlighting your interest in startups and your passion for Flutter development.";
    // final List suggestion_summary = [
    //   "**Add a Professional Summary/Objective:** Craft a concise 2-3 sentence summary at the top of your resume. This is a prime location to explicitly state your 'passion for Flutter development,' your 'strong interest in working with innovative startups like Newms,' and your commitment to 'writing clean, maintainable code following best practices.'",
    //   "**Tailor Project Descriptions (Minor):** Where appropriate and natural, subtly weave in phrases that reflect 'willingness to learn' or 'taking ownership,' e.g., 'Proactively learned and implemented BLoC for state management in the Notes App.'",
    //   "**Skills Section Keyword Enhancement:** While 'Flutter Development' is good, ensure terms like 'Mobile Application Development' are clearly visible if not already broadly covered. Consider a sub-section like 'Architectural Patterns: MVC, MVVM, BLoC' if space allows, to further highlight these specific skills.",
    //   "**Cover Letter is Crucial:** Your cover letter must explicitly address all 'eligibility' and 'other requirements'. Clearly state: \n    - Your availability for a work-from-home internship.\n    - Your ability to start between 1st Apr'25 and 6th May'25.\n    - Your availability for the 3-month duration.\n    - Reiterate your strong interest in Newms as a startup and your passion for Flutter.\n    - Briefly mention an example of your willingness to learn or take ownership.",
    //   "**Review Resume for Explicit Keywords:** Although your experience demonstrates many desired qualities, a strict ATS might look for exact phrases. If you can naturally incorporate 'clean code principles' or 'adherence to best practices' into a project or experience description, it could be beneficial."
    // ];
    // final List<String> matchingSkills = [
    //   "Flutter",
    //   "Firebase",
    //   "Dart",
    //   "REST API",
    //   "Model View Controller(MVC)",
    //   "Mobile Applications Development",
    //   "Collaboration"
    // ].cast<String>() ?? [];
    // final List<String> missingSkills = [
    //   "Explicit statement of 'Strong interest in working with a startup'",
    //   "Explicit statement of 'Passion for Flutter development'",
    //   "Keyword: 'Clean Code' (though implied by architecture use)",
    //   "Keyword: 'Best Practices' (though implied by architecture use)"
    // ].cast<String>() ?? [];

    // final List key_suggestions = [
    //   "Add a resume summary mentioning 'startup interest', 'passion for Flutter', 'clean code'.",
    //   "Use cover letter to explicitly confirm all eligibility (dates, WFH, duration) and 'other requirements'.",
    //   "Subtly add phrases for 'ownership' or 'learning' in project details.",
    //   "Ensure 'Mobile Application Development' is clear in skills."
    // ];

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
              HiringProbabilityBar(probabilityLevel: hiringProbability),
              const SizedBox(height: 24),
              VisualScoreRow(
                label: "ATS Score",
                percent: atsScore / 100,
                color: Colors.cyanAccent,
              ),

              VisualScoreRow(
                label: "Match Percentage",
                percent: matchPer / 100,
                color: Colors.orangeAccent,
                reverse: true,
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
                        analysisSummary,
                        style: GoogleFonts.rubik(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Matching Skills Section
              Text(
                "Matching Skills:",
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
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: matchingSkills.map((skill) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        skill,
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              const SizedBox(height: 30),

// Missing Skills Section
              Text(
                "Missing Skills / Phrases:",
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
              ...missingSkills.map((skill) => Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
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
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        skill,
                        style: GoogleFonts.rubik(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )).toList(),
              const SizedBox(height: 30),

              const SizedBox(height: 24),
              Text(
                "Summary of Suggestions:",
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                  shadows: [
                    const Shadow(blurRadius: 6, color: Colors.orangeAccent)
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...suggestions.map((item) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.orangeAccent.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.bolt,
                            color: Colors.orangeAccent, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] ?? '',
                                style: GoogleFonts.rubik(
                                  color: Colors.orangeAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['description'] ?? '',
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
              const SizedBox(height: 30),

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
              ...keySuggestions.map((s) => Container(
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
              // ATSChartSection(atsScore: atsScore, matchPercentage: matchPercentage),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text("Regenerate Resume"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    side: const BorderSide(color: Colors.cyanAccent),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> parseSuggestionSummary(List<dynamic> rawSuggestions) {
    return rawSuggestions.map((s) {
      if (s is String) {
        return {
          "title": "Suggestion",
          "description": s.trim(),
        };
      } else {
        return {
          "title": "Suggestion",
          "description": s.toString(),
        };
      }
    }).toList();
  }


// List<Map<String, dynamic>> parseSuggestionSummary(
  //     List<dynamic> rawSuggestions) {
  //   final RegExp regex = RegExp(r"\*\*(.*?):\*\*\s*(.*)", dotAll: true);
  //
  //   return rawSuggestions.map((s) {
  //     final match = regex.firstMatch(s.trim());
  //     if (match != null) {
  //       return {
  //         "title": match.group(1) ?? "",
  //         "description": match.group(2) ?? "",
  //       };
  //     } else {
  //       // fallback if pattern is not matched
  //       return {
  //         "title": "Suggestion",
  //         "description": s,
  //       };
  //     }
  //   }).toList();
  // }
}
