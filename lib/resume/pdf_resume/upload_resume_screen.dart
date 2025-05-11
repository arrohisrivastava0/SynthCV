// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:synthcv/resume/resume_service.dart'; // adjust path as needed
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// class UploadResumeScreen extends StatefulWidget {
//   const UploadResumeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<UploadResumeScreen> createState() => _UploadResumeScreenState();
// }
//
// class _UploadResumeScreenState extends State<UploadResumeScreen> {
//   File? _selectedFile;
//   bool _isUploading = false;
//   String? _uploadedUrl;
//
//   Future<void> _pickPdf() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     }
//   }
//
//   Future<void> _uploadPdf() async {
//     if (_selectedFile == null) return;
//
//     setState(() {
//       _isUploading = true;
//     });
//
//     final userId = Supabase.instance.client.auth.currentUser?.id;
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in')));
//       return;
//     }
//
//     final resumeService = ResumeService();
//     final url = await resumeService.uploadPdf(_selectedFile!, userId);
//
//     setState(() {
//       _uploadedUrl = url;
//       _isUploading = false;
//     });
//
//     if (url != null) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload successful!')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload failed')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Upload Resume (PDF)")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_selectedFile != null)
//               Text("Selected: ${_selectedFile!.path.split('/').last}"),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickPdf,
//               child: const Text("Choose PDF"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadPdf,
//               child: _isUploading ? const CircularProgressIndicator() : const Text("Upload to Supabase"),
//             ),
//             if (_uploadedUrl != null) ...[
//               const SizedBox(height: 20),
//               Text("Resume URL:"),
//               SelectableText(_uploadedUrl!),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:synthcv/resume/pdf_resume/resume_service.dart';
import 'package:synthcv/screens/home_screen.dart';
import 'package:synthcv/screens/job_description_input_screen.dart';
import 'package:synthcv/services/gemini_service.dart';
import 'package:synthcv/widget/simple_neon_button.dart';

class UploadResumeScreen extends StatefulWidget {
  const UploadResumeScreen({super.key});

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  File? _selectedFile;
  bool _isUploading = false;
  String? _uploadedUrl;

  // Future<void> _pickPDF(BuildContext context) async {
  //   final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //   if (result != null) {
  //     final file = result.files.first;
  //     // TODO: handle file upload
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected file: ${file.name}')));
  //   }
  // }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadPdf() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
    });

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User not logged in')));
      return;
    }

    final resumeService = ResumeService();
    final url = await resumeService.uploadPdf(_selectedFile!, userId);

    setState(() {
      _uploadedUrl = url;
      _isUploading = false;
    });

    if (url != null) {
      await extractTextFromPdf(_selectedFile!.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload successful!')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Upload failed')));
    }
  }

  Future<void> extractTextFromPdf(String path) async {
    final File file = File(path);
    final List<int> bytes = await file.readAsBytes();

    // Load PDF
    final PdfDocument document = PdfDocument(inputBytes: bytes);

    // Extract all text
    String text = PdfTextExtractor(document).extractText();

    print("Extracted text: $text");
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to submit a resume.')),
      );
      return;
    }
    try{
      final structured = await GeminiService.extractResumeJSON(text);
      final response= await supabase.from('uploaded_resumes').insert({
        'user_id': user.id,
        'resume_json': structured,
      })
          .select()
        .single();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume submitted successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobDescriptionInputScreen(resumeIdInit: response['id'])
        ),
      );
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Supabase error: ${e.message}')),
      );
      print('PostgrestException: $e');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
      print('Unexpected error: $e');
    }

    document.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handle back navigation
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Upload Your Resume',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.cyanAccent, blurRadius: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please select a PDF file to upload.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  NeonIconButton(
                    icon: Icons.upload_file,
                    label: _selectedFile != null
                        ? "Selected: ${_selectedFile!.path.split('/').last}"
                        : "Choose PDF",
                    onPressed: _pickPdf,
                    isDisabled: false,
                    // borderColor: Colors.cyanAccent,
                    glowColor: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 20),
                  NeonIconButton(
                    icon: Icons.edit,
                    label: "Upload Selected Resume",
                    isLoading: _isUploading,
                    isDisabled: _isUploading || _selectedFile == null,
                    onPressed: _uploadPdf,
                    // borderColor: Colors.purpleAccent,
                    glowColor: Colors.purpleAccent,
                  ),
                  // ElevatedButton.icon(
                  //   icon: const Icon(Icons.upload_file, color: Colors.white),
                  //
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.transparent,
                  //     shadowColor: Colors.cyanAccent,
                  //     elevation: 10,
                  //     side: const BorderSide(color: Colors.cyanAccent),
                  //     minimumSize: const Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //   ),
                  //   onPressed: () => _pickPdf(),
                  //   label: Text(
                  //     _selectedFile != null
                  //         ? "Selected: ${_selectedFile!.path.split('/').last}"
                  //         : "Choose PDF",
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // if (_selectedFile != null)
                  //   Text("Selected: ${_selectedFile!.path.split('/').last}"),
                  const SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: _isUploading ? null : _uploadPdf,
                  //   child: _isUploading
                  //       ? const CircularProgressIndicator()
                  //       : const Text("Upload to Supabase"),
                  // ),
                  // ElevatedButton.icon(
                  //   icon: const Icon(Icons.edit, color: Colors.white),
                  //   label: _isUploading
                  //       ? const CircularProgressIndicator()
                  //       : const Text(
                  //           "Upload Selected Resume",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.transparent,
                  //     shadowColor: Colors.purpleAccent,
                  //     elevation: 10,
                  //     side: const BorderSide(color: Colors.purpleAccent),
                  //     minimumSize: const Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //   ),
                  //   onPressed: (_isUploading || _selectedFile == null) ? null : _uploadPdf,
                  // ),
                  if (_uploadedUrl != null) ...[
                    const SizedBox(height: 20),
                    Text("Resume URL:"),
                    SelectableText(_uploadedUrl!),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
