import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static final String? _apiKey = dotenv.env['GEMINI_API_KEY'];
  static const String _baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  /// Core function to call Gemini API with a prompt and return response text.
  static Future<String?> _getRawGeminiResponse(String prompt) async {
    if (_apiKey == null) {
      print("❌ GEMINI_API_KEY is not set in .env");
      return null;
    }

    final uri = Uri.parse("$_baseUrl?key=$_apiKey");

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['candidates']?[0]?['content']?['parts']?[0]?['text'];
      } else {
        print("❌ Gemini API Error [${response.statusCode}]: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Gemini API Exception: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> extractResumeJSON(String rawResumeText) {
    final prompt = '''
    You are an AI assistant that reads raw resume text and extracts it into a clean and structured JSON format with the following fields:
- name
- email
- phone
- any other profile links or user ids list
- skills (list with respective categories)
- education (list of degree, university, year, cgpa)
- experience (split into work list wof title, company, dates, description, and leadership list of title, organization, dates, description)
- projects (list of name, technologies, date, description)
- certifications (list of name, organization, year, verification_link)

Here is the resume raw text:

$rawResumeText
Here is an example resultant JSON: 
{
  "name": "xyz",
  "email": "xyz@gmail.com",
  "phone": "(+91)827429494",
  "other_profiles": [
    {
      "type": "linkedin",
      "url": "linkedin.com/in/--"
    },
    {
      "type": "github",
      "url": "github.com/a---"
    },
    {...}
  ],
  "skills": {
    "Languages": [
      "Java",
      "C++",
    ],
    "Frameworks & Tools": [
      "Android SDK",
      "Flutter",
    ],
    "Hard Skills": [
      "Flutter Development",
      "Android Development",
    ],
    "Soft Skills": [
      "Project Management",
    ],
    "xyz" : [..]
  },
  "education": [
    {
      "degree": "btech",
      "institution": "abc University",
      "location": "city, state",
      "graduation_year": "yyyy",
      "grade": "CGPA: 6.55"
    },
    {
      "degree": "xyz",
      "institution": "xyz",
      "location": "city, state",
      "graduation_year": "yyyy",
      "grade": "Percentage: 80%"
    },
    {...}
  ],
  "experience": {
    "work": [
      {
        "title": "Android Developer",
        "company": "RemoDesk",
        "dates": "June 2024 - July 2024",
        "description": "Developed and maintained Android applications using Kotlin and Java, collaborated with a team of developers on feature design, and integrated REST APIs for data retrieval and processing. Conducted 10+ code reviews, optimized app performance by 15%, and enhanced UI design. Performed manual and automated testing to ensure 99% application quality, participated in weekly team meetings, and contributed to technical documentation guides."
      },
      {..}
    ],
    "leadership": [
      {
        "title": "Technical Lead",
        "organization": "VIT Bhopal University • Android Club",
        "dates": "May 2024 – Feb 2025",
        "description": [
          "Leading the technical department of the Android Club of VIT Bhopal University consisting of multiple tech departments with over 120 students.",
          "Led technical sessions on Android development for over 300 students in a Tech Event organized by VIT Bhopal University.",
          "Led and facilitated a hands-on workshops and delivered instructions on IoT, ML, and Android integration for over 130 students in the Android Fusion Event organized by Android Club VIT Bhopal University."
        ]
      },
      {...}
    ]
  },
  "projects": [
    {
      "name": "The Wall",
      "technologies": "Flutter, Firebase Firestore",
      "date": "January 2025",
      "description": "Built a full-featured social media application using Flutter and Firebase Firestore. Enabled users to post text updates on \"The Wall,\" connect with others, like posts and comments, add comments, and edit their profiles. Integrated real-time updates and scalable data handling for a smooth user experience.",
      "link": "http//..."
    },
    {...},
  ],
  "certifications": [
    {
      "name": "NPTEL Cloud Computing",
      "organization": "SWAYAM MHRD",
      "year": "2024",
      "verification_link": "http..."
    },
    {...}
  ]
}
''';
    return generateStructuredMap(prompt);
  }

  static Future<Map<String, dynamic>?> extractJobDescriptionJSON(String jdText) {
    final prompt = '''
Here is a job description:

$jdText

Extract this as structured JSON:
- title
- company
- required_skills
- responsibilities
- qualifications (list of eligibility and other requirements if any)
- keywords and their frequency and importance for ats score
''';
    return generateStructuredMap(prompt);
  }

  static String _stripMarkdownCodeBlock(String text) {
    final regex = RegExp(r'^```(?:json)?\s*([\s\S]*)\s*```$', multiLine: true);
    final match = regex.firstMatch(text.trim());
    return match != null ? match.group(1)!.trim() : text;
  }


  /// ✅ Returns parsed JSON from Gemini as a Map
  static Future<Map<String, dynamic>?> generateStructuredMap(
      String prompt) async {
    final rawText = await _getRawGeminiResponse(prompt);
    if (rawText == null) return null;

    try {
      final cleaned = _stripMarkdownCodeBlock(rawText);
      return jsonDecode(cleaned);
    } catch (e) {
      print("❌ Error parsing Gemini response: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> compareResumeWithJD({
    required Map<String, dynamic> resumeJson,
    required Map<String, dynamic> jdJson,
  }) async {
    final prompt = '''
    
You are an ATS (Applicant Tracking System) evaluation engine.
Compare the following resume with the job description very very strictly, such that if you estimate the score to be good, then repeat the analysis process and level the score down little bit until you are satisfied with the final score leaving no flaws left, since there will always be a missing skill definitely, to achieve perfection, keeping in mind the keywords, the quality of the resume and etc. Deeply analyze the resume and the job description to generate improvements based on very small details which may or may not be mentioned explicitly, and provide:

1. ATS Score (out of 100)
2. Keyword match percentage
3. Chance of getting hired (choose from [Excellent (ats score range: 85–100), Strong(ats score range: 70–84), Good(ats score range: 55–69), Fair(ats score range: 40–54), Low(ats score range: Below 40)])
4. Matching Skills
5. Missing Skills
6. Short summary of the analysis in active voice, as if talking directly to the candidate
7. Several deeply analyzed areas of Improvement (suggestions) with a title and a description [{"title": ' ', "description": ' '}]
8. Very short key points for suggestions to improve
9. Keyword Density: Number of times key terms appear

Resume:
${jsonEncode(resumeJson)}

Job Description:
${jsonEncode(jdJson)}

Respond in this example JSON format:
{
  "ats_score": any precise value between 1-100 can be float,
  "match_percentage" : 67.5 (float)
  "hiring_probability": " "
  "matching_skills": [...],
  "missing_skills": [...],
  "analysis_summary":"abc.. ",
  "suggestions": [{"title": ' ', "description": ' '}]
  "key_suggestions": [...]
  "keyword_density": ["keyword": ' ', "frequency": 2]
}
''';

    final raw = await _getRawGeminiResponse(prompt);
    if (raw == null) return null;
    try {
      final cleaned = _stripMarkdownCodeBlock(raw);
      return jsonDecode(cleaned);
    } catch (e) {
      print("❌ Error parsing Gemini response: $e");
      return null;
    }

  }
}
