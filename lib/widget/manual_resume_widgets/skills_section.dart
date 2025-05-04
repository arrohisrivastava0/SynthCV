import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key); // Add key here
  @override
  SkillsSectionState createState() => SkillsSectionState();
}

class SkillsSectionState extends State<SkillsSection> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
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
        backgroundColor: Colors.black87,
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

  void _removeSkill(String section, int index) {
    setState(() {
      _skillSections[section]?.removeAt(index);
    });
  }

  void _deleteSkillSection(String section) {
    setState(() {
      _skillSections.remove(section);
    });
  }

  void _editSkillSectionName(String oldName) {
    final controller = TextEditingController(text: oldName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text("Edit Section Name", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "e.g. Technical Skills",
            hintStyle: const TextStyle(color: Colors.white60),
            filled: true,
            fillColor: Colors.white.withOpacity(0.07),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty && !_skillSections.containsKey(newName)) {
                setState(() {
                  _skillSections[newName] = _skillSections.remove(oldName)!;
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text("Rename", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
    );
  }


  Widget _section(String title, List<TextEditingController> controllers) {
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
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () => _editSkillSectionName(title),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () => _deleteSkillSection(title),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...controllers.asMap().entries.map((entry) {
            final index = entry.key;
            final controller = entry.value;
            return Row(
              children: [
                Expanded(
                  child: buildInputField(
                    hint: "Enter a skill",
                    controller: controller,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => _removeSkill(title, index),
                ),
              ],
            );
          }).toList(),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => _addSkill(title),
              icon: const Icon(Icons.add, color: Colors.cyanAccent),
              label: const Text("Add Skill", style: TextStyle(color: Colors.cyanAccent)),
            ),
          ),
        ],
      ),
    );
  }


  // Widget _section(String title, List<Widget> children) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 16),
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.05),
  //       borderRadius: BorderRadius.circular(16),
  //       border: Border.all(color: Colors.white.withOpacity(0.15)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.cyanAccent.withOpacity(0.1),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //             shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         ...children,
  //       ],
  //     ),
  //   );
  // }

  Map<String, List<String>> getSkills() {
    final Map<String, List<String>> skills = {};
    _skillSections.forEach((section, controllers) {
      final values = controllers
          .map((controller) => controller.text.trim())
          .where((text) => text.isNotEmpty)
          .toList();
      if (values.isNotEmpty) {
        skills[section] = values;
      }
    });
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ..._skillSections.entries.map((entry) {
          // return _section(entry.key, [
          //   ...entry.value.map((controller) => buildInputField(
          //     hint: "Enter a skill",
          //     controller: controller,
          //   )),
          //   Align(
          //     alignment: Alignment.centerLeft,
          //     child: TextButton.icon(
          //       onPressed: () => _addSkill(entry.key),
          //       icon: const Icon(Icons.add, color: Colors.cyanAccent),
          //       label: const Text("Add Skill", style: TextStyle(color: Colors.cyanAccent)),
          //     ),
          //   ),
          // ]);
          ..._skillSections.entries.map((entry) {
          return _section(entry.key, entry.value);
          }),

        // }),
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
