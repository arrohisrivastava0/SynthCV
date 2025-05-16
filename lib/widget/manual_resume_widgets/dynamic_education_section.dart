import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';
import 'package:synthcv/widget/manual_resume_widgets/section.dart';

class DynamicEducationSection extends StatefulWidget {
  const DynamicEducationSection({Key? key}) : super(key: key);

  @override
  DynamicEducationSectionState createState() => DynamicEducationSectionState();
}

class DynamicEducationSectionState extends State<DynamicEducationSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // String? _highestEducation;

  List<Map<String, TextEditingController>> educationControllers = [];

  // final degreeController = TextEditingController();
  // final instituteController = TextEditingController();
  // final yearController = TextEditingController();
  // final cgpaController = TextEditingController();
  // final locationController = TextEditingController();
  //
  // final pgDegreeController = TextEditingController();
  // final pgUniController = TextEditingController();
  // final pgYearController = TextEditingController();
  // final pgCgpaController = TextEditingController();
  // final pgCityController = TextEditingController();
  // final pgStateController = TextEditingController();
  //
  // final ugDegreeController = TextEditingController();
  // final ugUniController = TextEditingController();
  // final ugYearController = TextEditingController();
  // final ugCgpaController = TextEditingController();
  // final ugCityController = TextEditingController();
  // final ugStateController = TextEditingController();
  //
  // final class12BoardController = TextEditingController();
  // final class12SchoolController = TextEditingController();
  // final class12YearController = TextEditingController();
  // final class12PercentageController = TextEditingController();
  // final class12CityController = TextEditingController();
  // final class12StateController = TextEditingController();
  //
  // final class10BoardController = TextEditingController();
  // final class10SchoolController = TextEditingController();
  // final class10YearController = TextEditingController();
  // final class10PercentageController = TextEditingController();
  // final class10CityController = TextEditingController();
  // final class10StateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addEducation();
  }

  // Widget _buildSection(String title, List<Widget> children) {
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
  //         Text(title,
  //             style: const TextStyle(
  //                 fontSize: 18,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold)),
  //         const SizedBox(height: 10),
  //         ...children,
  //       ],
  //     ),
  //   );
  // }

  // Widget _experienceFields(Map<String, TextEditingController> exp, {required bool isWork}) {
  //   return Column(
  //     children: [
  //       buildInputField(hint: "Degree*", controller: pgDegreeController),
  //       buildInputField(hint: "Institute*", controller: pgUniController),
  //       buildInputField(
  //           hint: "Graduation Year*", controller: pgYearController),
  //       buildInputField(
  //           hint: "Percentage/GPA*", controller: pgCgpaController),
  //       buildInputField(hint: "Location", controller: pgCityController),
  //       const SizedBox(height: 20),
  //     ],
  //   );
  // }

  void addEducation() {
    educationControllers.add({
      'degree': TextEditingController(),
      'institute': TextEditingController(),
      'graduation_year': TextEditingController(),
      'cgpa': TextEditingController(),
      'location': TextEditingController(),
    });
    setState(() {});
  }

  Widget section(List<Widget> children) {
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
          ...children,
        ],
      ),
    );
  }

  // List<Widget> _educationFields() {
  //   List<Widget> fields = [];
  //
  //   if (_highestEducation == null) return fields;
  //
  //   if (_highestEducation == "Post-Graduation") {
  //     fields.add(
  //       _buildSection("Post-Graduation", [
  //         buildInputField(hint: "Degree*", controller: pgDegreeController),
  //         buildInputField(hint: "University*", controller: pgUniController),
  //         buildInputField(
  //             hint: "Expected Graduation Year*", controller: pgYearController),
  //         buildInputField(
  //             hint: "Percentage/GPA*", controller: pgCgpaController),
  //         buildInputField(hint: "City", controller: pgCityController),
  //         buildInputField(hint: "State", controller: pgStateController),
  //       ]),
  //     );
  //   }
  //
  //   if (_highestEducation == "Post-Graduation" ||
  //       _highestEducation == "Graduation") {
  //     fields.add(
  //       _buildSection("Graduation", [
  //         buildInputField(hint: "Degree*", controller: ugDegreeController),
  //         buildInputField(hint: "University*", controller: ugUniController),
  //         buildInputField(
  //             hint: "Graduation Year*", controller: ugYearController),
  //         buildInputField(
  //             hint: "Percentage/GPA*", controller: ugCgpaController),
  //         buildInputField(hint: "City", controller: ugCityController),
  //         buildInputField(hint: "State", controller: ugStateController),
  //       ]),
  //     );
  //   }
  //
  //   if (_highestEducation == "Post-Graduation" ||
  //       _highestEducation == "Graduation" ||
  //       _highestEducation == "Senior Secondary") {
  //     fields.add(
  //       _buildSection("Senior Secondary (Class 12)", [
  //         buildInputField(hint: "Board", controller: class12BoardController),
  //         buildInputField(
  //             hint: "School Name*", controller: class12SchoolController),
  //         buildInputField(
  //             hint: "Passing Year*", controller: class12YearController),
  //         buildInputField(
  //             hint: "Percentage/GPA*", controller: class12PercentageController),
  //         buildInputField(hint: "City", controller: class12CityController),
  //         buildInputField(hint: "State", controller: class12StateController),
  //       ]),
  //     );
  //   }
  //
  //   if (_highestEducation == "Post-Graduation" ||
  //       _highestEducation == "Graduation" ||
  //       _highestEducation == "Senior Secondary" ||
  //       _highestEducation == "Higher Secondary") {
  //     fields.add(
  //       _buildSection("Higher Secondary (Class 10)", [
  //         buildInputField(hint: "Board", controller: class10BoardController),
  //         buildInputField(
  //             hint: "School Name*", controller: class10SchoolController),
  //         buildInputField(
  //             hint: "Passing Year*", controller: class10YearController),
  //         buildInputField(
  //             hint: "Percentage/GPA*", controller: class10PercentageController),
  //         buildInputField(hint: "City", controller: class10CityController),
  //         buildInputField(hint: "State", controller: class10StateController),
  //       ]),
  //     );
  //   }
  //
  //   return fields;
  // }

  bool hasValidEducation() {
    final educationList = getEducation();
    if (educationList.isEmpty) return false;

    for (final edu in educationList) {
      if ((edu['degree']?.isNotEmpty ?? false) &&
          (edu['institute']?.isNotEmpty ?? false) &&
          (edu['cgpa']?.isNotEmpty ?? false) &&
          (edu['graduation_year']?.isNotEmpty ?? false)) {
        return true;
      }
    }

    // for (final edu in educationList) {
    //   final level = edu['level'];
    //   if (level == 'Post-Graduation' || level == 'Graduation') {
    //     if ((edu['degree']?.isNotEmpty ?? false) &&
    //         (edu['university']?.isNotEmpty ?? false) &&
    //         (edu['graduation_year']?.isNotEmpty ?? false) &&
    //         (edu['cgpa']?.isNotEmpty ?? false) &&
    //         (edu['school']?.isNotEmpty ?? false) &&
    //         (edu['passing_year']?.isNotEmpty ?? false) &&
    //         (edu['percentage']?.isNotEmpty ?? false)) {
    //       return true;
    //     }
    //   } else if (level == 'Senior Secondary' || level == 'Higher Secondary') {
    //     if ((edu['school']?.isNotEmpty ?? false) &&
    //         (edu['passing_year']?.isNotEmpty ?? false) &&
    //         (edu['percentage']?.isNotEmpty ?? false)) {
    //       return true;
    //     }
    //   }
    // }

    return false;
  }

  List<Map<String, String>> getEducation() {
    return educationControllers
        .map((cert) {
          return {
            "name": cert["name"]?.text.trim() ?? '',
            "monthYear": cert["monthYear"]?.text.trim() ?? '',
            "link": cert["link"]?.text.trim() ?? '',
          };
        })
        .where((c) => c.values.any((value) => value.isNotEmpty))
        .toList();

    // List<Map<String, String>> education = [];
    //
    // if (_highestEducation == "Post-Graduation") {
    //   education.add({
    //     'grade': pgCgpaController.text.trim(),
    //     'degree': pgDegreeController.text.trim(),
    //     'location':
    //         "${pgCityController.text.trim()}, ${pgStateController.text.trim()}",
    //     'institution': pgUniController.text.trim(),
    //     'graduation_year': pgYearController.text.trim(),
    //   });
    // }
    //
    // if (_highestEducation == "Post-Graduation" ||
    //     _highestEducation == "Graduation") {
    //   education.add({
    //     'level': 'Graduation',
    //     'degree': ugDegreeController.text.trim(),
    //     'university': ugUniController.text.trim(),
    //     'graduation_year': ugYearController.text.trim(),
    //     'cgpa': ugCgpaController.text.trim(),
    //     'city': ugCityController.text.trim(),
    //     'state': ugStateController.text.trim(),
    //   });
    // }
    //
    // if (_highestEducation == "Post-Graduation" ||
    //     _highestEducation == "Graduation" ||
    //     _highestEducation == "Senior Secondary") {
    //   education.add({
    //     'level': 'Senior Secondary',
    //     'board': class12BoardController.text.trim(),
    //     'school': class12SchoolController.text.trim(),
    //     'passing_year': class12YearController.text.trim(),
    //     'percentage': class12PercentageController.text.trim(),
    //     'city': class12CityController.text.trim(),
    //     'state': class12StateController.text.trim(),
    //   });
    // }
    //
    // if (_highestEducation == "Post-Graduation" ||
    //     _highestEducation == "Graduation" ||
    //     _highestEducation == "Senior Secondary" ||
    //     _highestEducation == "Higher Secondary") {
    //   education.add({
    //     'level': 'Higher Secondary',
    //     'board': class10BoardController.text.trim(),
    //     'school': class10SchoolController.text.trim(),
    //     'passing_year': class10YearController.text.trim(),
    //     'percentage': class10PercentageController.text.trim(),
    //     'city': class10CityController.text.trim(),
    //     'state': class10StateController.text.trim(),
    //   });
    // }
    //
    // return education;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Important to call this when using KeepAlive mixin

    return Column(
      children: [
        ...educationControllers.asMap().entries.map((entry) {
          // int index = entry.key;
          var edu = entry.value;
          return FormSectionCard(
            children: [
                buildInputField(hint: "Degree*", controller: edu["degree"]!),
                buildInputField(hint: "Institute*", controller: edu["institute"]!),
                buildInputField(
                    hint: "Graduation Year*", controller: edu["graduation_year"]!),
                buildInputField(hint: "Percentage/GPA*", controller: edu["cgpa"]!),
                buildInputField(hint: "Location", controller: edu["location"]!),
            ],
          );

          // return section([
          //   buildInputField(hint: "Degree*", controller: edu["degree"]!),
          //   buildInputField(hint: "Institute*", controller: edu["institute"]!),
          //   buildInputField(
          //       hint: "Graduation Year*", controller: edu["graduation_year"]!),
          //   buildInputField(hint: "Percentage/GPA*", controller: edu["cgpa"]!),
          //   buildInputField(hint: "Location", controller: edu["location"]!),
          // ]);
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: addEducation,
            icon: const Icon(Icons.add, color: Colors.cyanAccent),
            label: const Text("Add Education",
                style: TextStyle(color: Colors.cyanAccent)),
          ),
        ),
        // section([
        //   ...educationControllers
        //       .map((e) =>
        //       _experienceFields(e, isWork: true)),
        //   Align(
        //     alignment: Alignment.centerLeft,
        //     child: TextButton.icon(
        //       onPressed: () => buildSec(educationControllers),
        //       icon: const Icon(Icons.add, color: Colors.cyanAccent),
        //       label: const Text("Add Project",
        //           style: TextStyle(color: Colors.cyanAccent)),
        //     ),
        //   ),
        // ]),
        // _buildSection("Education Level", [
        //   DropdownButtonFormField<String>(
        //     value: _highestEducation,
        //     dropdownColor: const Color(0xFF1A1A1A),
        //     style: const TextStyle(color: Colors.white),
        //     decoration: InputDecoration(
        //       filled: true,
        //       fillColor: Colors.white.withOpacity(0.07),
        //       hintText: "Select Highest Education",
        //       hintStyle: const TextStyle(color: Colors.white54),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //     ),
        //     items: const [
        //       DropdownMenuItem(
        //           value: "Post-Graduation", child: Text("Post-Graduation")),
        //       DropdownMenuItem(value: "Graduation", child: Text("Graduation")),
        //       DropdownMenuItem(
        //           value: "Senior Secondary",
        //           child: Text("Senior Secondary (12th)")),
        //       DropdownMenuItem(
        //           value: "Higher Secondary",
        //           child: Text("Higher Secondary (10th)")),
        //     ],
        //     onChanged: (value) {
        //       setState(() {
        //         _highestEducation = value;
        //       });
        //     },
        //   ),
        // ]),
        // ..._educationFields(),
      ],
    );
  }
}
