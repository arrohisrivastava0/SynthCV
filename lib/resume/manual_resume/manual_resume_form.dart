import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/resume/manual_resume/resume_preview_page.dart';
import 'package:synthcv/widget/buildInputField.dart';
import 'package:synthcv/widget/manual_resume_widgets/certifications_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/dynamic_education_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/dynamic_experience_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/projects_section.dart';
import 'package:synthcv/widget/manual_resume_widgets/skills_section.dart';
import 'package:synthcv/widget/neon_button.dart';
// import 'package:synthcv/widget/neon_section.dart';
// import 'package:synthcv/widget/neon_section.dart';


class ManualResumeForm extends StatefulWidget {
  const ManualResumeForm({super.key});

  @override
  State<ManualResumeForm> createState() => _ManualResumeFormState();
}

class _ManualResumeFormState extends State<ManualResumeForm> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey _basicInfoKey = GlobalKey();
  // final educationKey = GlobalKey<DynamicEducationSectionState>();
  // final skillsKey = GlobalKey<SkillsSectionState>();
  // final experienceKey = GlobalKey<ExperienceSectionState>();
  // final projectKey = GlobalKey<ProjectsSectionState>();
  // final certificationKey = GlobalKey<CertificationsSectionState>();
  final GlobalKey<SkillsSectionState> _skillsKey = GlobalKey<SkillsSectionState>();
  final GlobalKey<DynamicEducationSectionState> _educationKey = GlobalKey<DynamicEducationSectionState>();
  final GlobalKey<ExperienceSectionState> _experienceKey = GlobalKey<ExperienceSectionState>();
  final GlobalKey<ProjectsSectionState> _projectKey = GlobalKey<ProjectsSectionState>();
  final GlobalKey<CertificationsSectionState> _certificationKey = GlobalKey<CertificationsSectionState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  // Future<void> submitResume() async {
  //   if (!_formKey.currentState!.validate()) return;
  //
  //   setState(() => isLoading = true);
  //   final educationData = educationKey.currentState?.getEducation() ?? [];
  //   final skillsData = skillsKey.currentState?.getSkills() ?? [];
  //   final experienceData = experienceKey.currentState?.getExperiences() ?? [];
  //   final projectData = projectKey.currentState?.getProjects() ?? [];
  //   final certification = _certificationKey.currentState?.getCertifications() ?? [];
  //
  //   final resumeData = {
  //     'name': nameController.text.trim(),
  //     'email': emailController.text.trim(),
  //     'phone': phoneController.text.trim(),
  //     'education': educationData,
  //     'experience': experienceData,
  //     'skills': skillsData,
  //     'projects': projectData,
  //     'certifications': certification,
  //     'submitted_at': DateTime.now().toIso8601String(),
  //   };
  //
  //   final user = Supabase.instance.client.auth.currentUser;
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Not logged in.')));
  //     setState(() => isLoading = false);
  //     return;
  //   }
  //
  //   try {
  //     final response = await Supabase.instance.client
  //         .from('manual_resumes')
  //         .insert({'user_id': user.id, 'data': resumeData});
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resume saved!')));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
  //   }
  //
  //   setState(() => isLoading = false);
  //
  // }




  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }


  void previewResume() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name, Email, and Phone are required."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return; // Stop navigation if any are empty
    }

    final skills = _skillsKey.currentState?.getSkills() ?? {};
    final education = _educationKey.currentState?.getEducation() ?? [];
    final experience = _experienceKey.currentState?.getExperiences() ?? [];
    final project = _projectKey.currentState?.getProjects() ?? [];
    final certification = _certificationKey.currentState?.getCertifications() ?? [];

    final resumeData = {
      'name': name,
      'email': email,
      'phone': phone,
      'education': education,
      'experience': experience,
      'skills': skills,
      'projects': project,
      'certifications': certification,
      'submitted_at': DateTime.now().toIso8601String(),
    };
    print("Education: ${resumeData['education']}");
    if (education.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select your highest level of education.')));
      // showSnackBar("Please select your highest level of education.");
      scrollTo(_educationKey);
      return;
    }

    if (skills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please add at least one skill.')));
      // showSnackBar("Please add at least one skill.");
      scrollTo(_skillsKey);
      return;
    }


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResumePreviewPage(resumeData: resumeData),
      ),
    );
  }


  // void previewResume() {
  //   final skills = _skillsKey.currentState?.getSkills() ?? {};
  //   final education = _educationKey.currentState?.getEducation() ?? [];
  //   final experience = _experienceKey.currentState?.getExperiences() ?? [];
  //   final project = _projectKey.currentState?.getProjects() ?? [];
  //   final certification = _certificationKey.currentState?.getCertifications() ?? [];
  //
  //   final resumeData = {
  //     'name': nameController.text.trim(),
  //     'email': emailController.text.trim(),
  //     'phone': phoneController.text.trim(),
  //     'education': education,
  //     'experience': experience,
  //     'skills': skills,
  //     'projects': project,
  //     'certifications': certification,
  //     'submitted_at': DateTime.now().toIso8601String(),
  //   };
  //
  //   print("Resume Data: $resumeData");
  //   print("Experience: ${resumeData['experience']}");
  //   print("Education: ${resumeData['education']}");
  //   print("Skills: ${resumeData['skills']}");
  //
  //
  //
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ResumePreviewPage(resumeData: resumeData),
  //     ),
  //   );
  // }


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
                KeyedSubtree(
                  key: _basicInfoKey,
                  child: NeonSection(
                    title: "Basic Information",
                    children: [
                      buildInputField(hint: 'Full Name', controller: nameController, icon: Icons.person, isRequired: true),
                      buildInputField(hint: 'Email', controller: emailController, icon: Icons.email, isRequired: true),
                      buildInputField(hint: 'Phone', controller: phoneController, icon: Icons.phone, isRequired: true),
                    ],
                  ),
                ),
                // NeonSection(title: "Basic Information", children: [
                //   buildInputField(icon: Icons.person, hint: 'Full Name', controller: nameController),
                //   buildInputField(icon: Icons.email, hint: 'Email', controller: emailController),
                //   buildInputField(icon: Icons.phone, hint: 'Phone', controller: phoneController),
                // ]),
                NeonSection(title: 'Education', children: [DynamicEducationSection(key: _educationKey)]),
                NeonSection(title: 'Experience', children: [ExperienceSection(key: _experienceKey)]),
                NeonSection(title: 'Skills', children: [SkillsSection(key: _skillsKey)]),
                NeonSection(title: 'Projects', children: [ProjectsSection(key: _projectKey)]),
                NeonSection(title: 'Certifications', children: [CertificationsSection(key: _certificationKey)]),
                const SizedBox(height: 20),
                NeonButton(
                  text: "Preview Resume",
                  isLoading: isLoading,
                  onPressed: previewResume,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
