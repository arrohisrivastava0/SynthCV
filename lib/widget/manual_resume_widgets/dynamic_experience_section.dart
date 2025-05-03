import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({Key? key}) : super(key: key);
  @override
  ExperienceSectionState createState() => ExperienceSectionState();
}

class ExperienceSectionState extends State<ExperienceSection> {
  List<Map<String, TextEditingController>> workExperienceControllers = [];
  List<Map<String, TextEditingController>> leadershipControllers = [];

  void _addExperience(List<Map<String, TextEditingController>> list) {
    list.add({
      'role': TextEditingController(),
      'company': TextEditingController(),
      'start': TextEditingController(),
      'end': TextEditingController(),
      'description': TextEditingController(),
    });
    setState(() {});
  }

  Widget _experienceFields(Map<String, TextEditingController> exp, {required bool isWork}) {
    return Column(
      children: [
        buildInputField(hint: isWork ? 'Role' : 'Position', controller: exp['role']!),
        buildInputField(hint: 'Company / Organization', controller: exp['company']!),
        buildInputField(hint: 'Start (Month, Year)', controller: exp['start']!),
        buildInputField(hint: 'End (Month, Year)', controller: exp['end']!),
        buildInputField(hint: 'Description', controller: exp['description']!, maxLines: 2),
        const SizedBox(height: 20),
      ],
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

  Map<String, List<Map<String, String>>> getExperiences() {
    List<Map<String, String>> extractData(List<Map<String, TextEditingController>> controllers) {
      return controllers.map((entry) {
        return {
          'role': entry['role']!.text.trim(),
          'company': entry['company']!.text.trim(),
          'start': entry['start']!.text.trim(),
          'end': entry['end']!.text.trim(),
          'description': entry['description']!.text.trim(),
        };
      }).where((entry) => entry.values.any((v) => v.isNotEmpty)).toList();
    }

    return {
      'work': extractData(workExperienceControllers),
      'leadership': extractData(leadershipControllers),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _section("Work Experience", [
          ...workExperienceControllers.map((e) => _experienceFields(e, isWork: true)),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => _addExperience(workExperienceControllers),
              icon: const Icon(Icons.add, color: Colors.cyanAccent),
              label: const Text("Add Work Experience", style: TextStyle(color: Colors.cyanAccent)),
            ),
          ),
        ]),
        _section("Leadership Experience", [
          ...leadershipControllers.map((e) => _experienceFields(e, isWork: false)),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => _addExperience(leadershipControllers),
              icon: const Icon(Icons.add, color: Colors.purpleAccent),
              label: const Text("Add Leadership Experience", style: TextStyle(color: Colors.purpleAccent)),
            ),
          ),
        ]),
      ],
    );
  }
}
