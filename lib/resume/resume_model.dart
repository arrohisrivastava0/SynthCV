class ResumeModel {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final List<String> skills;
  final String experience;
  final String education;

  ResumeModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.skills,
    required this.experience,
    required this.education,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'skills': skills,
    'experience': experience,
    'education': education,
  };
}
