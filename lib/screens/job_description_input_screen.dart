// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';
//
// class JobDescriptionInputScreen extends StatefulWidget {
//   final Function(String) onJobDescriptionSubmitted;
//
//   const JobDescriptionInputScreen({required this.onJobDescriptionSubmitted, super.key});
//
//   @override
//   State<JobDescriptionInputScreen> createState() => _JobDescriptionInputScreenState();
// }
//
// class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
//   final TextEditingController _jdController = TextEditingController();
//   String? uploadedJDText;
//
//   Future<void> _pickPDF() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//     if (result != null && result.files.single.path != null) {
//       final file = File(result.files.single.path!);
//       // PDFDoc doc = await PDFDoc.fromFile(file);
//       // final text = await doc.text;
//       // setState(() {
//       //   uploadedJDText = text;
//       //   _jdController.text = text;
//       // });
//     }
//   }
//
//   void _submitJD() {
//     final jd = _jdController.text.trim();
//     if (jd.isNotEmpty) {
//       widget.onJobDescriptionSubmitted(jd);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Job description submitted!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter or upload a job description.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Enter Job Description')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton.icon(
//               onPressed: _pickPDF,
//               icon: const Icon(Icons.upload_file),
//               label: const Text('Upload JD as PDF'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _jdController,
//               maxLines: 10,
//               decoration: const InputDecoration(
//                 hintText: 'Paste or edit job description here...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitJD,
//               child: const Text('Submit Job Description'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:synthcv/screens/ats_analysis_screen.dart';
import 'package:synthcv/services/gemini_service.dart';
import 'package:synthcv/widget/simple_neon_button.dart';

class JobDescriptionInputScreen extends StatefulWidget {
  final Function(String) onJobDescriptionSubmitted;

  const JobDescriptionInputScreen(
      {required this.onJobDescriptionSubmitted, super.key});

  @override
  State<JobDescriptionInputScreen> createState() =>
      _JobDescriptionInputScreenState();
}
//
// class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
//   File? _selectedFile;
//   final TextEditingController _jdController = TextEditingController();
//   String? uploadedJDText;
//
//   Future<void> _pickPDF() async {
//     final result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//     if (result != null && result.files.single.path != null) {
//       final filePath = result.files.single.path!;
//       setState(() {
//         _selectedFile = File(filePath);
//       });
//
//       await extractTextFromPdf(filePath);
//     }
//   }
//
//   // Future<List<int>> _readDocumentData(File file) async {
//   //   final ByteData data = await rootBundle.load(file.path);
//   //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   // }
//
//   Future<void> extractTextFromPdf(String path) async {
//     final File file = File(path);
//     final List<int> bytes = await file.readAsBytes();
//
//     // Load PDF
//     final PdfDocument document = PdfDocument(inputBytes: bytes);
//
//     // Extract all text
//     String text = PdfTextExtractor(document).extractText();
//     print("Extracted text: $text");
//     document.dispose();
//   }
//
//   Future<void> _submitJD() async {
//     final supabase = Supabase.instance.client;
//     final user = supabase.auth.currentUser;
//
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('You must be logged in to submit a resume.')),
//       );
//       return;
//     }
//
//     // await extractTextFromPdf(_selectedFile!.path);
//
//     final jd = _jdController.text.trim();
//
//     if (jd.isNotEmpty) {
//       widget.onJobDescriptionSubmitted(jd);
//       try {
//         await supabase.from('job_descriptions').insert({
//           'user_id': user.id,
//           'jd_text': jd,
//           'created_at': DateTime.now().toIso8601String(),
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Job description submitted!')),
//         );
//       } on PostgrestException catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Supabase error: ${e.message}')),
//         );
//         print('PostgrestException: $e');
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Unexpected error: $e')),
//         );
//         print('Unexpected error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please enter or upload a job description.')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Job Description"),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               _NeonButton(
//                 onPressed: _pickPDF,
//                 icon: Icons.upload_file,
//                 label: "Upload JD as PDF",
//                 glowColor: Colors.cyanAccent,
//               ),
//               const SizedBox(height: 24),
//               _GlowingTextField(
//                 controller: _jdController,
//                 hint: "Paste or edit job description here...",
//               ),
//               const SizedBox(height: 30),
//               _NeonButton(
//                 onPressed: _submitJD,
//                 label: "Submit Job Description",
//                 glowColor: Colors.purpleAccent,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
  File? _selectedFile;
  final TextEditingController _jdController = TextEditingController();
  bool _isPDFSelected = false;
  bool _isTextEntered = false;

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;

      setState(() {
        _selectedFile = File(filePath);
        _isPDFSelected = true;
        _isTextEntered = false;
        _jdController.clear(); // Clear text input
      });
    }
  }

  Future<String> extractTextFromPdf(String path) async {
    final bytes = await File(path).readAsBytes();
    final doc = PdfDocument(inputBytes: bytes);
    final text = PdfTextExtractor(doc).extractText();
    doc.dispose();
    return text;
  }

  Future<void> _submitJD() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login required to submit.')),
      );
      return;
    }

    String? jdContent;

    if (_isPDFSelected && _selectedFile != null) {
      jdContent = await extractTextFromPdf(_selectedFile!.path);
    } else if (_isTextEntered && _jdController.text.trim().isNotEmpty) {
      jdContent = _jdController.text.trim();
    }

    if (jdContent == null || jdContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload or enter a JD.')),
      );
      return;
    }

    try {
      final structured = await GeminiService.extractJobDescriptionJSON(jdContent);

      await supabase.from('job_descriptions').insert({
        'user_id': user.id,
        'jd_json': structured,
        'created_at': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job description submitted!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ATSAnalysisScreen(
            atsScore: 78,
            matchPercentage: 82,
            hiringProbability: "Moderate",
            suggestions: [
              "Add 'Firebase' under skills.",
              "Mention your internship at ABC in the experience section.",
              "Highlight your leadership in project XYZ."
            ],
            onRegenerateResume: () {
              // Navigate to resume builder or call regeneration logic
            },
          ),
        ),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }



  // Future<void> _submitJD() async {
  //   final supabase = Supabase.instance.client;
  //   final user = supabase.auth.currentUser;
  //
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Login required to submit.')),
  //     );
  //     return;
  //   }
  //
  //   String? jdContent;
  //
  //   if (_isPDFSelected && _selectedFile != null) {
  //     jdContent = await extractTextFromPdf(_selectedFile!.path);
  //   } else if (_isTextEntered && _jdController.text.trim().isNotEmpty) {
  //     jdContent = _jdController.text.trim();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please upload or enter a JD.')),
  //     );
  //     return;
  //   }
  //
  //   if (jdContent==null) {
  //     try {
  //       final structured = await GeminiService.extractJobDescriptionJSON(jdContent!);
  //
  //       await supabase.from('job_descriptions').insert({
  //         'user_id': user.id,
  //         'jd_text': jdContent,
  //         'structured_json': structured,
  //         'created_at': DateTime.now().toIso8601String(),
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Job description submitted!')),
  //       );
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: $e')),
  //       );
  //     }
  //   }
  //   else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //           content: Text('Please enter or upload a job description.')),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _jdController.addListener(() {
      setState(() {
        _isTextEntered = _jdController.text.trim().isNotEmpty;
        if (_isTextEntered) {
          _isPDFSelected = false;
          _selectedFile = null;
        }
      });
    });
  }

  @override
  void dispose() {
    _jdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Job Description")),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NeonIconButton(
                icon: Icons.upload_file,
                label: _selectedFile != null
                    ? "Selected: ${_selectedFile!.path.split('/').last}"
                    : "Choose PDF",
                onPressed: _pickPDF,
                isDisabled: _isTextEntered,
                // borderColor: Colors.cyanAccent,
                glowColor: Colors.cyanAccent,
              ),
              // _NeonButton(
              //   onPressed: _isTextEntered ? null : () => _pickPDF(),
              //   icon: Icons.upload_file,
              //   label: _isPDFSelected
              //       ? "PDF Uploaded"
              //       : "Upload JD as PDF",
              //   glowColor:
              //   _isPDFSelected ? Colors.greenAccent : Colors.cyanAccent,
              // ),
              const SizedBox(height: 24),
              _GlowingTextField(
                controller: _jdController,
                hint: "Paste or edit job description here...",
                enabled: !_isPDFSelected,
              ),
              const SizedBox(height: 30),
              _NeonButton(
                onPressed: _submitJD,
                label: "Submit Job Description",
                glowColor: Colors.purpleAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Neon-style glowing button
class _NeonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final Color glowColor;

  const _NeonButton({
    required this.onPressed,
    required this.label,
    required this.glowColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.5),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: glowColor.withOpacity(0.15),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.orbitron(fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: glowColor.withOpacity(0.7)),
        ),
        icon: icon != null
            ? Icon(icon, color: glowColor)
            : const SizedBox.shrink(),
        label: Text(label),
      ),
    );
  }
}

// Glassy glowing TextField
class _GlowingTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool enabled;

  const _GlowingTextField({
    required this.controller,
    required this.hint,
    this.enabled=true

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        enabled: enabled,
        controller: controller,
        maxLines: 12,
        style: GoogleFonts.rubik(color: Colors.white, fontSize: 15),
        decoration: InputDecoration.collapsed(
          hintText: hint,
          hintStyle: GoogleFonts.rubik(color: Colors.white54),
        ),
        cursorColor: Colors.cyanAccent,
      ),
    );
  }
}
