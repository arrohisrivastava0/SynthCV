import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/widget/buildInputField.dart';
import 'package:synthcv/widget/dynamic_education_section.dart';
import 'package:synthcv/widget/dynamic_experience_section.dart';
import 'package:synthcv/widget/projects_section.dart';
import 'package:synthcv/widget/skills_section.dart';

class ManualResumeForm extends StatefulWidget {
  const ManualResumeForm({super.key});

  @override
  State<ManualResumeForm> createState() => _ManualResumeFormState();
}

class _ManualResumeFormState extends State<ManualResumeForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final educationController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();
  final projectsController = TextEditingController();

  bool isLoading = false;

  Future<void> submitResume() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final resumeData = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'education': educationController.text.trim(),
      'experience': experienceController.text.trim(),
      'skills': skillsController.text.trim(),
      'projects': projectsController.text.trim(),
      'submitted_at': DateTime.now().toIso8601String(),
    };

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not logged in.')));
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('manual_resumes')
          .insert({'user_id': user.id, 'data': resumeData});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resume saved!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manual Resume Form')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF121212), // deep dark base
              Color(0xFF1A1B2F), // subtle bluish tone
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _section("Basic Information", [
                  buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                  // _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                  buildInputField(icon: Icons.email, hint: 'Email', controller: emailController),
                  buildInputField(icon: Icons.phone, hint: 'Phone', controller: phoneController),
                ]),
                _section("Education", [DynamicEducationSection()]),
                _section("Experience", [ExperienceSection()]),
                _section("Skills", [SkillsSection()]),
                _section("Projects", [ProjectsSection()]),
                _section("Projects", [
                  textField(projectsController, 'Projects (Title + Description)', maxLines: 3),
                ]),
                _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                _buildInputField(icon: Icons.email, hint: 'Email', controller: emailController),
                _buildInputField(icon: Icons.phone, hint: 'Phone', controller: phoneController),
                _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                _buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                textField(nameController, 'Full Name'),
                textField(emailController, 'Email'),
                textField(phoneController, 'Phone'),
                textField(educationController, 'Education (Degree, College, Year)', maxLines: 2),
                textField(experienceController, 'Experience (Role, Company, Duration)', maxLines: 2),
                textField(skillsController, 'Skills (comma separated)'),
                textField(projectsController, 'Projects (Title + Description)', maxLines: 3),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : submitResume,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit Resume'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required IconData icon, required String hint, required TextEditingController controller}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
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



  String highestEducation = 'Graduation';

  // Widget _educationSection() {
  //   return _section("Education", [
  //     DropdownButtonFormField<String>(
  //       decoration: _inputDecoration("Highest Level of Education"),
  //       value: highestEducation,
  //       items: ['Post-Graduation', 'Graduation', 'Senior Secondary', 'Higher Secondary']
  //           .map((level) => DropdownMenuItem(value: level, child: Text(level)))
  //           .toList(),
  //       onChanged: (value) {
  //         setState(() {
  //           highestEducation = value!;
  //         });
  //       },
  //     ),
  //     if (['Post-Graduation', 'Graduation'].contains(highestEducation))
  //       _buildInputField(hint: 'Post-Graduation Degree (e.g., M.Tech)', controller: pgDegreeController),
  //     if (['Post-Graduation', 'Graduation'].contains(highestEducation))
  //       _buildInputField(hint: 'Post-Graduation Year', controller: pgYearController),
  //     if (['Post-Graduation', 'Graduation'].contains(highestEducation))
  //       _buildInputField(hint: 'Post-Graduation CGPA', controller: pgCgpaController),
  //
  //     if (['Post-Graduation', 'Graduation'].contains(highestEducation))
  //       const Divider(color: Colors.white38),
  //
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Graduation Degree (e.g., B.Tech)', controller: gradDegreeController),
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Graduation Year', controller: gradYearController),
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Graduation CGPA', controller: gradCgpaController),
  //
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary'].contains(highestEducation))
  //       const Divider(color: Colors.white38),
  //
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary', 'Higher Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Class 12th Board', controller: class12BoardController),
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary', 'Higher Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Class 12th School Name', controller: class12SchoolController),
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary', 'Higher Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Class 12th Passing Year', controller: class12YearController),
  //     if (['Post-Graduation', 'Graduation', 'Senior Secondary', 'Higher Secondary'].contains(highestEducation))
  //       _buildInputField(hint: 'Class 12th Percentage', controller: class12PercentageController),
  //
  //     const Divider(color: Colors.white38),
  //
  //     _buildInputField(hint: 'Class 10th Board', controller: class10BoardController),
  //     _buildInputField(hint: 'Class 10th School Name', controller: class10SchoolController),
  //     _buildInputField(hint: 'Class 10th Passing Year', controller: class10YearController),
  //     _buildInputField(hint: 'Class 10th Percentage', controller: class10PercentageController),
  //   ]);
  // }



  Widget textField(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }
}
