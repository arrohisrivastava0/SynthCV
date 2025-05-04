import 'package:flutter/material.dart';

class ResumePreviewPage extends StatelessWidget {
  final Map<String, dynamic> resumeData;

  const ResumePreviewPage({super.key, required this.resumeData});

  Widget _buildSection(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              )),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _buildListSection(List<dynamic> data, List<String> fields) {
    return Column(
      children: data.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fields.map((f) {
              final val = item[f] ?? '';
              return Text(
                "$f: $val",
                style: const TextStyle(color: Colors.white),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Preview")),
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection("Basic Information", Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${resumeData['name']}", style: const TextStyle(color: Colors.white)),
                Text("Email: ${resumeData['email']}", style: const TextStyle(color: Colors.white)),
                Text("Phone: ${resumeData['phone']}", style: const TextStyle(color: Colors.white)),
              ],
            )),
            _buildSection("Education", _buildListSection(resumeData['education'], ['degree', 'school', 'year'])),
            _buildSection("Experience", _buildListSection(resumeData['experience'], ['position', 'company', 'duration'])),
            _buildSection("Skills", Wrap(
              spacing: 8,
              children: (resumeData['skills'] as List<dynamic>).map((skill) =>
                  Chip(label: Text(skill, style: const TextStyle(color: Colors.black)), backgroundColor: Colors.cyanAccent)).toList(),
            )),
            _buildSection("Projects", _buildListSection(resumeData['projects'], ['title', 'description', 'tech'])),
            _buildSection("Certifications", _buildListSection(resumeData['certifications'], ['name', 'monthYear', 'link'])),
          ],
        ),
      ),
    );
  }
}
