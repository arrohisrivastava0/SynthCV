import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
    );
  }

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
