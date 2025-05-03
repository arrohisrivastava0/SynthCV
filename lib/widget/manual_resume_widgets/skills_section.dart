import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class SkillsSection extends StatefulWidget {
  @override
  _SkillsSectionState createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final Map<String, List<TextEditingController>> _skillSections = {
    "Hard Skills": [TextEditingController(), TextEditingController()],
    "Soft Skills": [TextEditingController(), TextEditingController()],
  };

  void _addSkill(String section) {
    setState(() {
      _skillSections[section]!.add(TextEditingController());
    });
  }

  void _addNewSkillSection(String newSection) {
    if (newSection.trim().isEmpty || _skillSections.containsKey(newSection)) return;
    setState(() {
      _skillSections[newSection] = [TextEditingController()];
    });
  }

  void _promptNewSkillSection() {
    final newSectionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("New Skill Section", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: newSectionController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "e.g. Languages",
            hintStyle: const TextStyle(color: Colors.white60),
            filled: true,
            fillColor: Colors.white.withOpacity(0.07),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addNewSkillSection(newSectionController.text.trim());
              Navigator.of(context).pop();
            },
            child: const Text("Add", style: TextStyle(color: Colors.cyanAccent)),
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
        ..._skillSections.entries.map((entry) {
          return _section(entry.key, [
            ...entry.value.map((controller) => buildInputField(
              hint: "Enter a skill",
              controller: controller,
            )),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _addSkill(entry.key),
                icon: const Icon(Icons.add, color: Colors.cyanAccent),
                label: const Text("Add Skill", style: TextStyle(color: Colors.cyanAccent)),
              ),
            ),
          ]);
        }),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _promptNewSkillSection,
            icon: const Icon(Icons.playlist_add, color: Colors.purpleAccent),
            label: const Text("Add Skill Section", style: TextStyle(color: Colors.purpleAccent)),
          ),
        ),
      ],
    );
  }
}
