import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);
  @override
  ProjectsSectionState createState() => ProjectsSectionState();
}

class ProjectsSectionState extends State<ProjectsSection> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
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

  void _editProjectName(int index) {
    final TextEditingController _editController = TextEditingController(text: _projects[index]["name"]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: const Text("Edit Project Name", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _editController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Project Name",
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
            child: const Text("Save", style: TextStyle(color: Colors.cyanAccent)),
            onPressed: () {
              if (_editController.text.trim().isNotEmpty) {
                setState(() {
                  _projects[index]["name"] = _editController.text.trim();
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }


  // Widget _section(int index, Map<String, dynamic> project) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 8),
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.05),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.white.withOpacity(0.15)),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 project["name"],
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //             IconButton(
  //               icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
  //               onPressed: () => _editProjectName(index),
  //               tooltip: 'Edit project name',
  //             ),
  //             IconButton(
  //               icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
  //               onPressed: () => _deleteProject(index),
  //               tooltip: 'Delete project',
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         buildInputField(hint: "Keywords (comma separated)", controller: project["keywords"]),
  //         buildInputField(hint: "Month & Year", controller: project["monthYear"]),
  //         buildInputField(hint: "Description", controller: project["description"]),
  //       ],
  //     ),
  //   );
  // }


  Widget _section(int index, String title, List<Widget> children) {
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white70, size: 20),
                onPressed: () => _editProjectName(index),
                tooltip: 'Edit project name',
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white70, size: 20),
                onPressed: () => _deleteProject(index),
                tooltip: 'Delete project',
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  List<Map<String, String>> getProjects() {
    return _projects.map((project) {
      return {
        "name": project["name"]?.toString() ?? '',
        "keywords": (project["keywords"] as TextEditingController).text.trim(),
        "monthYear": (project["monthYear"] as TextEditingController).text.trim(),
        "description": (project["description"] as TextEditingController).text.trim(),
      };
    }).where((p) => p.values.any((value) => value.isNotEmpty)).toList();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        // ..._projects.asMap().entries.map((entry) {
        //   int index = entry.key;
        //   var project = entry.value;
        //   return _section(index, project);
        // }),

        ..._projects.asMap().entries.map((entry) {
          int index = entry.key;
          var project = entry.value;
          return _section(index, project["name"], [
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
