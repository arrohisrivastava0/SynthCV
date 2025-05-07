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

class JobDescriptionInputScreen extends StatefulWidget {
  final Function(String) onJobDescriptionSubmitted;

  const JobDescriptionInputScreen(
      {required this.onJobDescriptionSubmitted, super.key});

  @override
  State<JobDescriptionInputScreen> createState() =>
      _JobDescriptionInputScreenState();
}

class _JobDescriptionInputScreenState extends State<JobDescriptionInputScreen> {
  File? _selectedFile;
  final TextEditingController _jdController = TextEditingController();
  String? uploadedJDText;

  Future<void> _pickPDF() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
      // TODO: Add PDF parsing logic
    }
  }

  // Future<List<int>> _readDocumentData(File file) async {
  //   final ByteData data = await rootBundle.load(file.path);
  //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // }

  Future<void> extractTextFromPdf(String path) async {
    final File file = File(path);
    final List<int> bytes = await file.readAsBytes();

    // Load PDF
    final PdfDocument document = PdfDocument(inputBytes: bytes);

    // Extract all text
    String text = PdfTextExtractor(document).extractText();
    print("Extracted text: $text");
    document.dispose();
  }

  Future<void> _submitJD() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('You must be logged in to submit a resume.')),
      );
      return;
    }

    await extractTextFromPdf(_selectedFile!.path);

    final jd = _jdController.text.trim();

    if (jd.isNotEmpty) {
      widget.onJobDescriptionSubmitted(jd);
      try {
        await supabase.from('formed_resumes').insert({
          'user_id': user.id,
          'jd_text': jd,
          'created_at': DateTime.now().toIso8601String(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job description submitted!')),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter or upload a job description.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Description"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NeonButton(
                onPressed: _pickPDF,
                icon: Icons.upload_file,
                label: "Upload JD as PDF",
                glowColor: Colors.cyanAccent,
              ),
              const SizedBox(height: 24),
              _GlowingTextField(
                controller: _jdController,
                hint: "Paste or edit job description here...",
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

  const _GlowingTextField({
    required this.controller,
    required this.hint,
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
