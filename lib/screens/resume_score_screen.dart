import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/widget/ats_analysis_widgets/visual_score.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ResumeScoreScreen extends StatefulWidget {
  final Map<String, dynamic>? score;

  const ResumeScoreScreen({super.key, required this.score});

  @override
  State<ResumeScoreScreen> createState() => _ResumeScoreScreenState();

}

class _ResumeScoreScreenState extends State<ResumeScoreScreen> {
  String resumeUrl = "https://hthievkrcnffgfzzuuye.supabase.co/storage/v1/object/sign/resumes/resumes/e7ed2f53-fd09-4ba0-9423-ac5782b20386/1746895638609.pdf?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5X2FhMzFjNzE0LTlhNTItNDhkNi1iMGZkLTAyMDQ0MTk2ZTQ1NCJ9.eyJ1cmwiOiJyZXN1bWVzL3Jlc3VtZXMvZTdlZDJmNTMtZmQwOS00YmEwLTk0MjMtYWM1NzgyYjIwMzg2LzE3NDY4OTU2Mzg2MDkucGRmIiwiaWF0IjoxNzQ3MTcxMjYwLCJleHAiOjE3NDc3NzYwNjB9._s6MpEEuS9VT1LDqS1arSv8OjGovSdDdEF-D3rog8UY";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // loadLatestResume();
  }

  Future<void> loadLatestResume() async {
    final path = await fetchLatestResumePath();
    if (path != null) {
      final url = await getResumeDownloadUrl(path);
      setState(() {
        resumeUrl = url!;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<String?> fetchLatestResumePath() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return null;

    final response = await supabase.storage
        .from('your_bucket_name') // e.g., 'resumes'
        .list(path: 'resumes/$userId');

    if (response.isEmpty) return null;

    // Sort files by name assuming they're timestamps
    response.sort((a, b) => b.name.compareTo(a.name)); // latest first

    return 'resumes/$userId/${response.first.name}'; // latest file path
  }

  Future<String?> getResumeDownloadUrl(String filePath) async {
    final supabase = Supabase.instance.client;

    final result = await supabase.storage
        .from('your_bucket_name') // same bucket
        .createSignedUrl(filePath, 60 * 60); // valid for 1 hour

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final double resumeScore = widget.score?['resume_score'] ?? 77.6;
    final List strengths = widget.score?['strengths'] ??
        [
          {
            "area": 'hehe',
            "comment": 'hello niggas how are you ifne sankyu',
            "score_impact": '+10'
          }
        ];
    final List areasOfImprovement = widget.score?['areas_of_improvement'] ??
        [
          {
            "area": 'hehe',
            "comment": 'hello niggas how are you ifne sankyu',
            "score_impact": '-9'
          }
        ];
    final String overallSummary = widget.score?['overall_summary'] ??
        "Your resume demonstrates a strong technical foundation for this Flutter Development internship. You clearly showcase experience with key required skills like Flutter, Firebase, Dart, REST API, and MVC through your projects and skills list. Your project work is directly relevant. To elevate your application further, you'll want to more explicitly align your resume with the 'Other Requirements' of the role, particularly by highlighting your interest in startups and your passion for Flutter development.";
    final List<String> keyRecommendations = widget.score?['key_recommendations'] ??
        [
          "Add a resume summary mentioning 'startup interest', 'passion for Flutter', 'clean code'.",
          "Use cover letter to explicitly confirm all eligibility (dates, WFH, duration) and 'other requirements'.",
          "Subtly add phrases for 'ownership' or 'learning' in project details.",
          "Ensure 'Mobile Application Development' is clear in skills."
        ];

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (resumeUrl == null) {
      return const Center(child: Text("No resume found."));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
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
                Text(
                  "Uploaded Resume",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyanAccent,
                    shadows: const [Shadow(blurRadius: 6, color: Colors.cyanAccent)],
                  ),
                ),
                SfPdfViewer.network(resumeUrl),
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
