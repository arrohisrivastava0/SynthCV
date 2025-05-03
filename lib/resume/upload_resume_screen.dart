import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:synthcv/resume/resume_service.dart'; // adjust path as needed
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadResumeScreen extends StatefulWidget {
  const UploadResumeScreen({Key? key}) : super(key: key);

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  File? _selectedFile;
  bool _isUploading = false;
  String? _uploadedUrl;

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in')));
      return;
    }

    final resumeService = ResumeService();
    final url = await resumeService.uploadPdf(_selectedFile!, userId);

    setState(() {
      _uploadedUrl = url;
      _isUploading = false;
    });

    if (url != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload successful!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Upload failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Resume (PDF)")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedFile != null)
              Text("Selected: ${_selectedFile!.path.split('/').last}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickPdf,
              child: const Text("Choose PDF"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadPdf,
              child: _isUploading ? const CircularProgressIndicator() : const Text("Upload to Supabase"),
            ),
            if (_uploadedUrl != null) ...[
              const SizedBox(height: 20),
              Text("Resume URL:"),
              SelectableText(_uploadedUrl!),
            ]
          ],
        ),
      ),
    );
  }
}
