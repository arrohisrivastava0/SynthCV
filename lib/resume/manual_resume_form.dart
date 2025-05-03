import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/widget/buildInputField.dart';
import 'package:synthcv/widget/manual_resume_widgets/certifications_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/dynamic_education_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/dynamic_experience_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/projects_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/skills_section.dart';
import 'package:synthcv/widget/neon_button.dart';
import 'package:synthcv/widget/neon_section.dart';

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
                NeonSection(title: "Basic Information", children: [
                  buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                  buildInputField(icon: Icons.email, hint: 'Email', controller: emailController),
                  buildInputField(icon: Icons.phone, hint: 'Phone', controller: phoneController),
                ]),
                NeonSection(title: 'Education', children: [DynamicEducationSection()]),
                NeonSection(title: 'Experience', children: [ExperienceSection()]),
                NeonSection(title: 'Skills', children: [SkillsSection()]),
                NeonSection(title: 'Projects', children: [ProjectsSection()]),
                NeonSection(title: 'Certifications', children: [CertificationsSection()]),
                // _section("Experience", [ExperienceSection()]),
                // _section("Skills", [SkillsSection()]),
                // _section("Projects", [ProjectsSection()]),
                // _section("Certifications", [CertificationsSection()]),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: isLoading ? null : submitResume,
                //   child: isLoading
                //       ? const CircularProgressIndicator()
                //       : const Text('Submit Resume'),
                // ),
                NeonButton(
                  text: "Submit Resume",
                  isLoading: isLoading,
                  onPressed: submitResume,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
