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

  static Future<String?> extractResumeJSON(String rawResumeText) {
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
''';
    return _getRawGeminiResponse(prompt);
  }

  static Future<String?> extractJobDescriptionJSON(String jdText) {
    final prompt = '''
Here is a job description:

$jdText

Extract this as structured JSON:
- title
- company
- required_skills
- responsibilities
- qualifications (list of eligibility and other requirements if any)
''';
    return _getRawGeminiResponse(prompt);
  }

  /// ✅ Returns parsed JSON from Gemini as a Map
  static Future<Map<String, dynamic>?> generateStructuredMap(
      String prompt) async {
    final rawText = await _getRawGeminiResponse(prompt);
    if (rawText == null) return null;

    try {
      return jsonDecode(rawText);
    } catch (e) {
      print("Error parsing Gemini response: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> compareResumeWithJD({
    required Map<String, dynamic> resumeJson,
    required Map<String, dynamic> jdJson,
  }) async {
    final prompt = '''
You are an ATS (Applicant Tracking System) evaluation engine.

Compare the following resume with the job description and provide:

1. ATS Match Score (out of 100)
2. Chance of getting hired (choose from [Excellent Chance, Strong Chance, Good Chance, Fair Chance (with Focused Growth), Low Chance for this role (Focus on Growth Areas)])
3. Matching Skills
4. Missing Skills
5. Areas of Improvement (suggestions)

Resume:
${jsonEncode(resumeJson)}

Job Description:
${jsonEncode(jdJson)}

Respond in JSON format:
{
  "ats_score": 87,
  "chance_of_getting_hired": Strong Chance
  "matching_skills": [...],
  "missing_skills": [...],
  "suggestions": [...]
}
''';

    final raw = await _getRawGeminiResponse(prompt);
    if (raw == null) return null;

    try {
      return jsonDecode(raw);
    } catch (e) {
      print("❌ Failed to parse ATS comparison: $e");
      return null;
    }
  }
}
