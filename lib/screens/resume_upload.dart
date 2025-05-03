import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResumeUploadPage extends StatefulWidget {
  const ResumeUploadPage({Key? key}) : super(key: key);

  @override
  State<ResumeUploadPage> createState() => _ResumeUploadPageState();
}

class _ResumeUploadPageState extends State<ResumeUploadPage> {
  File? _resumeFile;
  String? _resumeText;
  bool _uploading = false;

  Future<void> _pickAndUploadPDF() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      setState(() => _resumeFile = file);

      final fileName = 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf';
      setState(() => _uploading = true);

      try {
        final storage = Supabase.instance.client.storage.from('resumes');
        await storage.upload(fileName, file);
        final url = storage.getPublicUrl(fileName);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Uploaded: $url')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      } finally {
        setState(() => _uploading = false);
      }
    }
  }

  void _navigateToManualForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ManualResumeForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Resume')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Resume PDF'),
              onPressed: _uploading ? null : _pickAndUploadPDF,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Fill Resume Manually'),
              onPressed: _navigateToManualForm,
            ),
          ],
        ),
      ),
    );
  }
}

class ManualResumeForm extends StatelessWidget {
  const ManualResumeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Resume Entry')),
      body: const Center(
        child: Text("Manual form goes here (Next Step)"),
      ),
    );
  }
}
