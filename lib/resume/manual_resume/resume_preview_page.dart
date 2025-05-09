// import 'package:flutter/material.dart';
//
// class ResumePreviewPage extends StatelessWidget {
//   final Map<String, dynamic> resumeData;
//
//   const ResumePreviewPage({super.key, required this.resumeData});
//
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         color: Colors.cyanAccent,
//         shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 8)],
//       ),
//     );
//   }
//
//   Widget _buildInfoTile(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         "$label: $value",
//         style: const TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     );
//   }
//
//   Widget _buildListSection(List<dynamic> items, List<String> fields) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: items.map((item) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white.withOpacity(0.2)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: fields.map((field) {
//               final value = item[field];
//               if (value == null || value.toString().trim().isEmpty) return SizedBox.shrink();
//               return Text(
//                 "$field: $value",
//                 style: const TextStyle(color: Colors.white70),
//               );
//             }).toList(),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildEducationPreview(List<dynamic> educationList) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: educationList.map((edu) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.white24),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: (edu as Map<String, dynamic>).entries.map((entry) {
//               return Text(
//                 "${entry.key[0].toUpperCase()}${entry.key.substring(1).replaceAll('_', ' ')}: ${entry.value}",
//                 style: const TextStyle(color: Colors.white),
//               );
//             }).toList(), // <-- fix for inner children
//           ),
//         );
//       }).toList(), // <-- fix for outer children
//     );
//   }
//
//   Widget buildSkillsSection(Map<String, List<String>> skills) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: skills.entries.map((entry) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.white.withOpacity(0.15)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyanAccent.withOpacity(0.2),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 entry.key,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: entry.value.map((skill) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.cyanAccent.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
//                     ),
//                     child: Text(
//                       skill,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildExperiencePreview(Map<String, List<dynamic>> experienceData) {
//     List<Map<String, String>> workList = List<Map<String, String>>.from(experienceData['work'] ?? []);
//     List<Map<String, String>> leadershipList = List<Map<String, String>>.from(experienceData['leadership'] ?? []);
//
//     Widget buildSection(String title, List<Map<String, String>> entries, Color accentColor) {
//       if (entries.isEmpty) return const SizedBox(); // Skip if no entries
//
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 12),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.white.withOpacity(0.1)),
//           boxShadow: [
//             BoxShadow(
//               color: accentColor.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 shadows: [Shadow(color: accentColor, blurRadius: 4)],
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...entries.map((entry) => Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Role: ${entry['role'] ??''}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                   Text("Company: ${entry['company'] ??''}", style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70)),
//                   Text('Duration: ${entry['start']} – ${entry['end']}', style: const TextStyle(fontSize: 13, color: Colors.white60)),
//                   if ((entry['description'] ?? '').isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 6.0),
//                       child: Text(entry['description'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.white)),
//                     ),
//                 ],
//               ),
//             )),
//           ],
//         ),
//       );
//     }
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildSection("Work Experience", workList, Colors.cyanAccent),
//         buildSection("Leadership Experience", leadershipList, Colors.purpleAccent),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final education = List<Map<String, dynamic>>.from(resumeData['education'] ?? []);
//     // final experience = List<Map<String, dynamic>>.from(resumeData['experience'] ?? []);
//     final projects = List<Map<String, dynamic>>.from(resumeData['projects'] ?? []);
//     final certifications = List<Map<String, dynamic>>.from(resumeData['certifications'] ?? []);
//     final skillsMap = <String, List<String>>{};
//     final rawSkills = resumeData['skills'];
//     if (rawSkills is Map) {
//       rawSkills.forEach((key, value) {
//         if (value is List) {
//           skillsMap[key.toString()] = value.map((e) => e.toString()).toList();
//         }
//       });
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Resume Preview")),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           children: [
//             _buildSectionTitle("Basic Information"),
//             _buildInfoTile("Name", resumeData['name']),
//             _buildInfoTile("Email", resumeData['email']),
//             _buildInfoTile("Phone", resumeData['phone']),
//             const SizedBox(height: 20),
//             _buildSectionTitle("Education"),
//             resumeData['education'] != null && resumeData['education'].isNotEmpty
//                 ? _buildEducationPreview(resumeData['education'])
//                 : const SizedBox(height: 20,),
//             _buildSectionTitle("Experience"),
//             resumeData['experience'] != null && resumeData['experience'].isNotEmpty
//                 ? _buildExperiencePreview(resumeData['experience'])
//                 : const SizedBox(),
//             _buildSectionTitle("Skills"),
//             buildSkillsSection(skillsMap),
//             const SizedBox(height: 20),
//             _buildSectionTitle("Projects"),
//             _buildListSection(projects, ['name', 'keywords', 'monthYear', 'description']),
//             const SizedBox(height: 20),
//             _buildSectionTitle("Certifications"),
//             _buildListSection(certifications, ['name', 'monthYear', 'link']),
//           ],
//         ),
//       ),
//     );
//   }
// }


//the correct version
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// extension StringCasingExtension on String {
//   String capitalize() => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
// }
//
//
// class ResumePreviewPage extends StatelessWidget {
//   final Map<String, dynamic> resumeData;
//
//   const ResumePreviewPage({super.key, required this.resumeData});
//
//   Widget _buildInfoTile(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         "$label: $value",
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildListSection(List<dynamic> items, List<String> fields) {
//     Map<String, String> labelMap = {
//       "name": "Name",
//       "keywords": "Technologies",
//       "monthYear": "Date",
//       "description": "Description",
//       "link": "Link",
//     };
//
//     return Column(
//       children: items.map((item) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.white.withOpacity(0.2)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyanAccent.withOpacity(0.2),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: fields.map((field) {
//               final value = item[field];
//               if (value == null || value.toString().trim().isEmpty) return const SizedBox.shrink();
//               final label = labelMap[field] ?? field.replaceAll('_', ' ').capitalize();
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 6),
//                 child: Text(
//                   "$label: $value",
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildEducationPreview(List<dynamic> educationList) {
//     Map<String, String> labelMap = {
//       "degree": "Degree",
//       "university": "University",
//       "graduation_year": "Graduation Year",
//       "cgpa": "CGPA",
//       "city": "City",
//       "state": "State",
//       "board": "Board",
//       "school": "School",
//       "passing_year": "Passing Year",
//       "percentage": "Percentage",
//     };
//
//     return Column(
//       children: educationList.map((edu) {
//         final level = edu['level'] ?? '';
//         final entries = Map<String, dynamic>.from(edu)..remove('level');
//
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.purpleAccent.withOpacity(0.2)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.purpleAccent.withOpacity(0.15),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 level,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [Shadow(color: Colors.purpleAccent, blurRadius: 4)],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               ...entries.entries.map((entry) {
//                 final label = labelMap[entry.key] ?? entry.key.replaceAll('_', ' ').capitalize();
//                 final value = entry.value.toString();
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 6),
//                   child: Text(
//                     "$label: $value",
//                     style: const TextStyle(color: Colors.white70),
//                   ),
//                 );
//               }).toList(),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//
//   Widget _buildSkillsSection(Map<String, List<String>> skills) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: skills.entries.map((entry) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyanAccent.withOpacity(0.2),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 entry.key,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: entry.value.map((skill) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.cyanAccent.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
//                     ),
//                     child: Text(
//                       skill,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildExperiencePreview(Map<String, List<dynamic>> experienceData) {
//     List<Map<String, String>> workList = List<Map<String, String>>.from(experienceData['work'] ?? []);
//     List<Map<String, String>> leadershipList = List<Map<String, String>>.from(experienceData['leadership'] ?? []);
//
//     Widget buildSection(String title, List<Map<String, String>> entries, Color accentColor) {
//       if (entries.isEmpty) return const SizedBox();
//
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 12),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.white.withOpacity(0.1)),
//           boxShadow: [
//             BoxShadow(
//               color: accentColor.withOpacity(0.15),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 shadows: [Shadow(color: accentColor, blurRadius: 4)],
//               ),
//             ),
//             const SizedBox(height: 12),
//             ...entries.map((entry) => Padding(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Role: ${entry['role'] ?? ''}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                   Text("Company: ${entry['company'] ?? ''}", style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70)),
//                   Text("Duration: ${entry['start']} – ${entry['end']}", style: const TextStyle(fontSize: 13, color: Colors.white60)),
//                   if ((entry['description'] ?? '').isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 6.0),
//                       child: Text(entry['description'] ?? '', style: const TextStyle(fontSize: 14, color: Colors.white)),
//                     ),
//                 ],
//               ),
//             )),
//           ],
//         ),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildSection("Work Experience", workList, Colors.cyanAccent),
//         buildSection("Leadership Experience", leadershipList, Colors.purpleAccent),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final projects = List<Map<String, dynamic>>.from(resumeData['projects'] ?? []);
//     final certifications = List<Map<String, dynamic>>.from(resumeData['certifications'] ?? []);
//     final skillsMap = <String, List<String>>{};
//     final rawSkills = resumeData['skills'];
//
//     if (rawSkills is Map) {
//       rawSkills.forEach((key, value) {
//         if (value is List) {
//           skillsMap[key.toString()] = value.map((e) => e.toString()).toList();
//         }
//       });
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Resume Preview")),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           children: [
//             NeonSection(
//               title: "Basic Information",
//               children: [
//                 _buildInfoTile("Name", resumeData['name']),
//                 _buildInfoTile("Email", resumeData['email']),
//                 _buildInfoTile("Phone", resumeData['phone']),
//               ],
//             ),
//             if (resumeData['education'] != null && resumeData['education'].isNotEmpty)
//               NeonSection(title: "Education", children: [_buildEducationPreview(resumeData['education'])]),
//             if (resumeData['experience'] != null && resumeData['experience'].isNotEmpty)
//               NeonSection(title: "Experience", children: [_buildExperiencePreview(resumeData['experience'])]),
//             if (skillsMap.isNotEmpty)
//               NeonSection(title: "Skills", children: [_buildSkillsSection(skillsMap)]),
//             if (projects.isNotEmpty)
//               NeonSection(title: "Projects", children: [_buildListSection(projects, ['name', 'keywords', 'monthYear', 'description'])]),
//             if (certifications.isNotEmpty)
//               NeonSection(title: "Certifications", children: [_buildListSection(certifications, ['name', 'monthYear', 'link'])]),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ResumePreviewPage extends StatelessWidget {
//   final Map<String, dynamic> resumeData;
//
//   const ResumePreviewPage({Key? key, required this.resumeData}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
// final projects = List<Map<String, dynamic>>.from(resumeData['projects'] ?? []);
// final certifications = List<Map<String, dynamic>>.from(resumeData['certifications'] ?? []);
// final skillsMap = <String, List<String>>{};
// final rawSkills = resumeData['skills'];
//
// if (rawSkills is Map) {
// rawSkills.forEach((key, value) {
// if (value is List) {
// skillsMap[key.toString()] = value.map((e) => e.toString()).toList();
// }
// });
// }
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF1C1C1E),
//       appBar: AppBar(
//         title: const Text('Resume Preview'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             NeonSection(
//               title: "Basic Information",
//               children: [
//                 _buildInfoTile("Name", resumeData['name']),
//                 _buildInfoTile("Email", resumeData['email']),
//                 _buildInfoTile("Phone", resumeData['phone']),
//               ],
//             ),
//             if (resumeData['education'] != null && resumeData['education'].isNotEmpty)
//               NeonSection(title: "Education", children: [_buildEducationPreview(resumeData['education'])]),
//             if (resumeData['experience'] != null && resumeData['experience'].isNotEmpty)
//               NeonSection(title: "Experience", children: [_buildExperiencePreview(resumeData['experience'])]),
//             if (skillsMap.isNotEmpty)
//               NeonSection(title: "Skills", children: [_buildSkillsSection(skillsMap)]),
//             if (projects.isNotEmpty)
//               NeonSection(title: "Projects", children: [_buildListSection(projects, ['name', 'keywords', 'monthYear', 'description'])]),
//             if (certifications.isNotEmpty)
//               NeonSection(title: "Certifications", children: [_buildListSection(certifications, ['name', 'monthYear', 'link'])]),
//           ],
//         ),
//       ),
//     );
//   }
//
//     Widget _buildSkillsSection(Map<String, List<String>> skills) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: skills.entries.map((entry) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyanAccent.withOpacity(0.2),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 entry.key,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 8,
//                 children: entry.value.map((skill) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.cyanAccent.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
//                     ),
//                     child: Text(
//                       skill,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//   //
//   // Widget _buildSkillsSection(List skills) {
//   //   return Wrap(
//   //     spacing: 12,
//   //     runSpacing: 12,
//   //     children: skills
//   //         .map((skill) => Chip(
//   //       label: Text(skill, style: const TextStyle(color: Colors.white)),
//   //       backgroundColor: Colors.deepPurple.withOpacity(0.6),
//   //     ))
//   //         .toList(),
//   //   );
//   // }
//
//   Widget _buildProjectSection(List projects) {
//     return Column(
//       children: projects.map((proj) {
//         return _buildCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(proj['name'] ?? '', style: _boldStyle()),
//               if (proj['description'] != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4.0),
//                   child: Text(proj['description'], style: _normalStyle()),
//                 ),
//               if (proj['keywords'] != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 4.0),
//                   child: Text("Technologies: ${proj['keywords'].join(', ')}", style: _subtleStyle()),
//                 ),
//               if (proj['monthYear'] != null)
//                 Text("Completed: ${proj['monthYear']}", style: _subtleStyle()),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildCertificationsSection(List certifications) {
//     return Column(
//       children: certifications.map((cert) {
//         return _buildCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(cert['name'] ?? '', style: _boldStyle()),
//               if (cert['monthYear'] != null)
//                 Text("Completed: ${cert['monthYear']}", style: _subtleStyle()),
//               if (cert['link'] != null)
//                 GestureDetector(
//                   onTap: () => launchUrl(Uri.parse(cert['link'])),
//                   child: Text("View Certificate", style: _linkStyle()),
//                 ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildEducationSection(List education) {
//     return Column(
//       children: education.map((edu) {
//         final e = Map<String, dynamic>.from(edu);
//         return _buildCard(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(e['degree'] ?? '', style: _boldStyle()),
//               if (e['institution'] != null)
//                 Text(e['institution'], style: _normalStyle()),
//               if (e['start'] != null && e['end'] != null)
//                 Text("Duration: ${e['start']} – ${e['end']}", style: _subtleStyle()),
//               if (e['grade'] != null)
//                 Text("Grade: ${e['grade']}", style: _subtleStyle()),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildCard({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.05),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.1)),
//       ),
//       child: child,
//     );
//   }
//
//   TextStyle _boldStyle() => GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
//   TextStyle _normalStyle() => GoogleFonts.poppins(fontSize: 14, color: Colors.white70);
//   TextStyle _subtleStyle() => GoogleFonts.poppins(fontSize: 13, color: Colors.white54);
//   TextStyle _linkStyle() => GoogleFonts.poppins(fontSize: 13, color: Colors.blueAccent, decoration: TextDecoration.underline);
// }
//
// // NeonSection reused from your code
// class NeonSection extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//
//   const NeonSection({super.key, required this.title, required this.children});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: GoogleFonts.orbitron(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.cyanAccent,
//                 shadows: [
//                   const Shadow(
//                     blurRadius: 12.0,
//                     color: Colors.cyanAccent,
//                     offset: Offset(0, 0),
//                   ),
//                 ],
//               )),
//           const SizedBox(height: 12),
//           ...children,
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/screens/job_description_input_screen.dart';
import 'package:synthcv/widget/neon_button.dart';

extension StringCasingExtension on String {
  String capitalize() => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}

class ResumePreviewPage extends StatelessWidget {
  final Map<String, dynamic> resumeData;

  const ResumePreviewPage({super.key, required this.resumeData});

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "$label: $value",
        style: GoogleFonts.rubik(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildListSection(List<dynamic> items, List<String> fields, Color accent) {
    Map<String, String> labelMap = {
      "name": "Name",
      "keywords": "Technologies",
      "monthYear": "Date",
      "description": "Description",
      "link": "Link",
    };

    return Column(
      children: items.map((item) {
        return NeonCard(
          glowColor: accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fields.map((field) {
              final value = item[field];
              if (value == null || value.toString().trim().isEmpty) return const SizedBox.shrink();
              final label = labelMap[field] ?? field.replaceAll('_', ' ').capitalize();

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                      color: Colors.white,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: accent.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    children: [
                      TextSpan(
                        text: "$label: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                      TextSpan(
                        text: value.toString(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }


  // Widget _buildListSection(List<dynamic> items, List<String> fields, Color accent) {
  //   Map<String, String> labelMap = {
  //     "name": "Name",
  //     "keywords": "Technologies",
  //     "monthYear": "Date",
  //     "description": "Description",
  //     "link": "Link",
  //   };
  //
  //   return Column(
  //     children: items.map((item) {
  //       return NeonCard(
  //         glowColor: accent,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: fields.map((field) {
  //             final value = item[field];
  //             if (value == null || value.toString().trim().isEmpty) return const SizedBox.shrink();
  //             final label = labelMap[field] ?? field.replaceAll('_', ' ').capitalize();
  //             return Padding(
  //               padding: const EdgeInsets.only(bottom: 6),
  //               child: Text(
  //                 "$label: $value",
  //                 style: GoogleFonts.rubik(color: Colors.white70),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildEducationPreview(List<dynamic> educationList) {
    Map<String, String> labelMap = {
      "degree": "Degree",
      "university": "University",
      "graduation_year": "Graduation Year",
      "cgpa": "CGPA",
      "city": "City",
      "state": "State",
      "board": "Board",
      "school": "School",
      "passing_year": "Passing Year",
      "percentage": "Percentage",
    };

    return Column(
      children: educationList.map((edu) {
        final level = edu['level'] ?? '';
        final entries = Map<String, dynamic>.from(edu)..remove('level');

        return NeonCard(
          glowColor: Colors.purpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level,
                style: GoogleFonts.orbitron(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [Shadow(color: Colors.purpleAccent, blurRadius: 6)],
                ),
              ),
              const SizedBox(height: 10),
              ...entries.entries.map((entry) {
                final label = labelMap[entry.key] ?? entry.key.replaceAll('_', ' ').capitalize();
                final value = entry.value.toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.rubik(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: Colors.purpleAccent.withOpacity(0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      children: [
                        TextSpan(
                          text: "$label: ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                          ),
                        ),
                        TextSpan(text: value),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }


  // Widget _buildEducationPreview(List<dynamic> educationList) {
  //   Map<String, String> labelMap = {
  //     "degree": "Degree",
  //     "university": "University",
  //     "graduation_year": "Graduation Year",
  //     "cgpa": "CGPA",
  //     "city": "City",
  //     "state": "State",
  //     "board": "Board",
  //     "school": "School",
  //     "passing_year": "Passing Year",
  //     "percentage": "Percentage",
  //   };
  //
  //   return Column(
  //     children: educationList.map((edu) {
  //       final level = edu['level'] ?? '';
  //       final entries = Map<String, dynamic>.from(edu)..remove('level');
  //
  //       return NeonCard(
  //         glowColor: Colors.purpleAccent,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               level,
  //               style: GoogleFonts.orbitron(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.white,
  //                 shadows: const [Shadow(color: Colors.purpleAccent, blurRadius: 4)],
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             ...entries.entries.map((entry) {
  //               final label = labelMap[entry.key] ?? entry.key.replaceAll('_', ' ').capitalize();
  //               final value = entry.value.toString();
  //               return Padding(
  //                 padding: const EdgeInsets.only(bottom: 6),
  //                 child: Text(
  //                   "$label: $value",
  //                   style: GoogleFonts.rubik(color: Colors.white70),
  //                 ),
  //               );
  //             }).toList(),
  //           ],
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildSkillsSection(Map<String, List<String>> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.entries.map((entry) {
        return NeonCard(
          glowColor: Colors.cyanAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: GoogleFonts.orbitron(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: const [Shadow(color: Colors.cyanAccent, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entry.value.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.rubik(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget _buildExperiencePreview(Map<String, List<dynamic>> experienceData) {
  //   List<Map<String, String>> workList = List<Map<String, String>>.from(experienceData['work'] ?? []);
  //   List<Map<String, String>> leadershipList = List<Map<String, String>>.from(experienceData['leadership'] ?? []);
  //
  //   Widget buildSection(String title, List<Map<String, String>> entries, Color accentColor) {
  //     if (entries.isEmpty) return const SizedBox();
  //
  //     return NeonCard(
  //       glowColor: accentColor,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             title,
  //             style: GoogleFonts.orbitron(
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //               shadows: [Shadow(color: accentColor, blurRadius: 4)],
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           ...entries.map((entry) => Padding(
  //             padding: const EdgeInsets.only(bottom: 16),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("Role: ${entry['role'] ?? ''}", style: GoogleFonts.rubik(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
  //                 Text("Company: ${entry['company'] ?? ''}", style: GoogleFonts.rubik(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white70)),
  //                 Text("Duration: ${entry['start']} – ${entry['end']}", style: GoogleFonts.rubik(fontSize: 13, color: Colors.white60)),
  //                 if ((entry['description'] ?? '').isNotEmpty)
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 6.0),
  //                     child: Text(entry['description'] ?? '', style: GoogleFonts.rubik(fontSize: 14, color: Colors.white)),
  //                   ),
  //               ],
  //             ),
  //           )),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       buildSection("Work Experience", workList, Colors.cyanAccent),
  //       buildSection("Leadership Experience", leadershipList, Colors.purpleAccent),
  //     ],
  //   );
  // }

  Widget _buildExperiencePreview(Map<String, List<dynamic>> experienceData) {
    List<Map<String, String>> workList = List<Map<String, String>>.from(experienceData['work'] ?? []);
    List<Map<String, String>> leadershipList = List<Map<String, String>>.from(experienceData['leadership'] ?? []);

    Widget buildSection(String title, List<Map<String, String>> entries, Color accentColor) {
      if (entries.isEmpty) return const SizedBox();

      return NeonCard(
        glowColor: accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(color: accentColor, blurRadius: 6)],
              ),
            ),
            const SizedBox(height: 12),
            ...entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExperienceText("Role", entry['role'], accentColor),
                  _buildExperienceText("Company", entry['company'], accentColor),
                  _buildExperienceText("Duration", "${entry['start']} – ${entry['end']}", accentColor),
                  if ((entry['description'] ?? '').isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        entry['description']!,
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ),
                ],
              ),
            )),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSection("Work Experience", workList, Colors.cyanAccent),
        buildSection("Leadership Experience", leadershipList, Colors.purpleAccent),
      ],
    );
  }

  Widget _buildExperienceText(String label, String? value, Color accentColor) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.rubik(
            fontSize: 15,
            color: Colors.white,
            height: 1.4,
            shadows: [
              Shadow(
                color: accentColor.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          children: [
            TextSpan(
              text: "$label: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
// 'name': resumeData['name'],
  // 'email': resumeData['email'],
  // 'phone': resumeData['phone'],
  // 'education': resumeData['education'],
  // 'experience': resumeData['experience'],
  // 'skills': resumeData['skills'],
  // 'projects': resumeData['projects'],
  // 'certifications': resumeData['certifications'],

  void submitResume(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to submit a resume.')),
      );
      return;
    }

    try {
      await supabase.from('resumes').insert({
        'user_id': user.id,
        'resume_data': resumeData,
        'created_at': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume submitted successfully!')),
      );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => JobDescriptionInputScreen(
      //       onJobDescriptionSubmitted: (jdText) {
      //         // Save to Supabase or pass to AI for keyword extraction
      //         print('JD submitted: $jdText');
      //       },
      //     ),
      //   ),
      // );

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
  }


  // void submitResume(BuildContext context) async {
  //   final supabase = Supabase.instance.client;
  //   final user = supabase.auth.currentUser;
  //
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('You must be logged in to submit a resume.')),
  //     );
  //     return;
  //   }
  //
  //   try {
  //     final response = await supabase.from('resumes').insert({
  //       'user_id': user.id,
  //       'resume_data': resumeData,
  //       'created_at': DateTime.now().toIso8601String(),
  //     });
  //
  //     if (response.error != null) {
  //       throw response.error!;
  //     }
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Resume submitted successfully!')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to submit resume: $e')),
  //     );
  //     print('Failed to submit resume: $e');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final projects = List<Map<String, dynamic>>.from(resumeData['projects'] ?? []);
    final certifications = List<Map<String, dynamic>>.from(resumeData['certifications'] ?? []);
    final skillsMap = <String, List<String>>{};
    final rawSkills = resumeData['skills'];

    if (rawSkills is Map) {
      rawSkills.forEach((key, value) {
        if (value is List) {
          skillsMap[key.toString()] = value.map((e) => e.toString()).toList();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Preview"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1A1B2F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            NeonSection(
              title: "Basic Information",
              children: [
                _buildInfoTile("Name", resumeData['name']),
                _buildInfoTile("Email", resumeData['email']),
                _buildInfoTile("Phone", resumeData['phone']),
              ],
            ),
            if (resumeData['education'] != null && resumeData['education'].isNotEmpty)
              NeonSection(title: "Education", children: [_buildEducationPreview(resumeData['education'])]),
            if (resumeData['experience'] != null && resumeData['experience'].isNotEmpty)
              NeonSection(title: "Experience", children: [_buildExperiencePreview(resumeData['experience'])]),
            if (skillsMap.isNotEmpty)
              NeonSection(title: "Skills", children: [_buildSkillsSection(skillsMap)]),
            if (projects.isNotEmpty)
              NeonSection(title: "Projects", children: [_buildListSection(projects, ['name', 'keywords', 'monthYear', 'description'], Colors.cyanAccent)]),
            if (certifications.isNotEmpty)
              NeonSection(title: "Certifications", children: [_buildListSection(certifications, ['name', 'monthYear', 'link'], Colors.purpleAccent)]),
            NeonButton(
              text: "Submit Resume",
              isLoading: false,
              onPressed: () => submitResume(context),
            ),
          ],
        ),
      ),
    );
  }
}

class NeonSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const NeonSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
                shadows: const [
                  Shadow(blurRadius: 12.0, color: Colors.cyanAccent, offset: Offset(0, 0)),
                ],
              )),
          Container(
            height: 2,
            width: 40,
            margin: const EdgeInsets.only(top: 6, bottom: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent.withOpacity(0.7), Colors.transparent],
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

// class NeonCard extends StatelessWidget {
//   final Widget child;
//   final Color glowColor;
//
//   const NeonCard({super.key, required this.child, required this.glowColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       padding: const EdgeInsets.all(16),
//       constraints: const BoxConstraints(minHeight: 120), // Ensures consistent min size
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.035),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: glowColor.withOpacity(0.35)),
//         boxShadow: [
//           BoxShadow(
//             color: glowColor.withOpacity(0.3),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

class NeonCard extends StatelessWidget {
  final Widget child;
  final Color glowColor;

  const NeonCard({super.key, required this.child, required this.glowColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // full width
      margin: const EdgeInsets.symmetric(vertical: 12), // more spacing
      padding: const EdgeInsets.all(18), // slightly more padding
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: glowColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}



// class NeonCard extends StatelessWidget {
//   final Widget child;
//   final Color glowColor;
//
//   const NeonCard({super.key, required this.child, required this.glowColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.04),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: glowColor.withOpacity(0.3)),
//         boxShadow: [
//           BoxShadow(
//             color: glowColor.withOpacity(0.25),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

