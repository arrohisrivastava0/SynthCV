import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class ProjectsSection extends StatefulWidget {
  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  List<Map<String, dynamic>> _projects = [];

  void _promptAndAddProject() {
    final TextEditingController _namePromptController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text("Enter Project Name", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _namePromptController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "e.g. Smart Traffic System",
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Add", style: TextStyle(color: Colors.cyanAccent)),
            onPressed: () {
              if (_namePromptController.text.trim().isNotEmpty) {
                setState(() {
                  _projects.add({
                    "name": _namePromptController.text.trim(),
                    "keywords": TextEditingController(),
                    "monthYear": TextEditingController(),
                    "description": TextEditingController(),
                  });
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._projects.asMap().entries.map((entry) {
          int index = entry.key;
          var project = entry.value;
          return _section(project["name"], [
            buildInputField(hint: "Keywords (comma separated)", controller: project["keywords"]),
            buildInputField(hint: "Month & Year", controller: project["monthYear"]),
            buildInputField(hint: "Description", controller: project["description"]),
          ]);
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _promptAndAddProject,
            icon: const Icon(Icons.add, color: Colors.cyanAccent),
            label: const Text("Add Project", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ),
      ],
    );
  }
}
