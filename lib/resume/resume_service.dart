// import 'dart:io';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
//
// class ResumeService {
//   final SupabaseClient _client = Supabase.instance.client;
//
//   Future<String?> uploadPdf(File pdfFile, String userId) async {
//     final String filePath = 'resumes/$userId/${basename(pdfFile.path)}';
//
//     final response = await _client.storage
//         .from('resumes')
//         .upload(filePath, pdfFile);
//
//     if (response.isEmpty) {
//       return null;
//     }
//
//     final url = _client.storage.from('resumes').getPublicUrl(filePath);
//     return url;
//   }
//
//   Future<void> saveFormResume(Map<String, dynamic> resumeData, String userId) async {
//     await _client.from('resumes_form').insert({...resumeData, 'user_id': userId});
//   }
// }

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResumeService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String?> uploadPdf(File file, String userId) async {
    final fileName = 'resumes/$userId/${DateTime.now().millisecondsSinceEpoch}.pdf';

    try {
      final response = await _client.storage.from('resumes').upload(fileName, file);
      if (response.isEmpty) return null;

      final publicUrl = _client.storage.from('resumes').getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}
