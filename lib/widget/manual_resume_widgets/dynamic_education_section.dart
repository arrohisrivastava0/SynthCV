import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class DynamicEducationSection extends StatefulWidget {
  @override
  _DynamicEducationSectionState createState() => _DynamicEducationSectionState();
}

class _DynamicEducationSectionState extends State<DynamicEducationSection> {
  String? _highestEducation;

  final pgDegreeController = TextEditingController();
  final pgUniController = TextEditingController();
  final pgYearController = TextEditingController();
  final pgCgpaController = TextEditingController();
  final pgCityController = TextEditingController();
  final pgStateController = TextEditingController();

  final ugDegreeController = TextEditingController();
  final ugUniController = TextEditingController();
  final ugYearController = TextEditingController();
  final ugCgpaController = TextEditingController();
  final ugCityController = TextEditingController();
  final ugStateController = TextEditingController();

  final class12BoardController = TextEditingController();
  final class12SchoolController = TextEditingController();
  final class12YearController = TextEditingController();
  final class12PercentageController = TextEditingController();
  final class12CityController = TextEditingController();
  final class12StateController = TextEditingController();

  final class10BoardController = TextEditingController();
  final class10SchoolController = TextEditingController();
  final class10YearController = TextEditingController();
  final class10PercentageController = TextEditingController();
  final class10CityController = TextEditingController();
  final class10StateController = TextEditingController();

  Widget _buildSection(String title, List<Widget> children) {
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
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  // List<Widget> _educationFields() {
  //   List<Widget> fields = [];
  //
  //   if (_highestEducation == "Post-Graduation") {
  //     fields.addAll([
  //       _buildSection("Post-Graduation", [
  //         _buildInputField(hint: "Degree", controller: pgDegreeController),
  //         _buildInputField(hint: "Expected Graduation Year", controller: pgYearController),
  //         _buildInputField(hint: "CGPA", controller: pgCgpaController),
  //       ])
  //     ]);
  //   }
  //
  //   if (_highestEducation == "Post-Graduation" || _highestEducation == "Graduation") {
  //     fields.addAll([
  //       _buildSection("Graduation", [
  //         _buildInputField(hint: "Degree", controller: ugDegreeController),
  //         _buildInputField(hint: "Graduation Year", controller: ugYearController),
  //         _buildInputField(hint: "CGPA", controller: ugCgpaController),
  //       ])
  //     ]);
  //   }
  //
  //   if (_highestEducation == "Post-Graduation" ||
  //       _highestEducation == "Graduation" ||
  //       _highestEducation == "Senior Secondary") {
  //     fields.addAll([
  //       _buildSection("Senior Secondary (Class 12)", [
  //         _buildInputField(hint: "Board", controller: class12BoardController),
  //         _buildInputField(hint: "School Name", controller: class12SchoolController),
  //         _buildInputField(hint: "Passing Year", controller: class12YearController),
  //         _buildInputField(hint: "Percentage", controller: class12PercentageController),
  //       ])
  //     ]);
  //   }
  //
  //   fields.addAll([
  //     _buildSection("Higher Secondary (Class 10)", [
  //       _buildInputField(hint: "Board", controller: class10BoardController),
  //       _buildInputField(hint: "School Name", controller: class10SchoolController),
  //       _buildInputField(hint: "Passing Year", controller: class10YearController),
  //       _buildInputField(hint: "Percentage", controller: class10PercentageController),
  //     ])
  //   ]);
  //
  //   return fields;
  // }

  List<Widget> _educationFields() {
    List<Widget> fields = [];

    if (_highestEducation == "Post-Graduation") {
      fields.add(
        _buildSection("Post-Graduation", [
          buildInputField(hint: "Degree", controller: pgDegreeController),
          buildInputField(hint: "University", controller: pgUniController),
          buildInputField(hint: "Expected Graduation Year", controller: pgYearController),
          buildInputField(hint: "CGPA", controller: pgCgpaController),
          buildInputField(hint: "City", controller: pgUniController),
          buildInputField(hint: "State", controller: pgUniController),
        ]),
      );
    }

    if (_highestEducation == "Post-Graduation" || _highestEducation == "Graduation") {
      fields.add(
        _buildSection("Graduation", [
          buildInputField(hint: "Degree", controller: ugDegreeController),
          buildInputField(hint: "University", controller: ugUniController),
          buildInputField(hint: "Graduation Year", controller: ugYearController),
          buildInputField(hint: "CGPA", controller: ugCgpaController),
        ]),
      );
    }

    if (_highestEducation == "Post-Graduation" ||
        _highestEducation == "Graduation" ||
        _highestEducation == "Senior Secondary") {
      fields.add(
        _buildSection("Senior Secondary (Class 12)", [
          buildInputField(hint: "Board", controller: class12BoardController),
          buildInputField(hint: "School Name", controller: class12SchoolController),
          buildInputField(hint: "Passing Year", controller: class12YearController),
          buildInputField(hint: "Percentage", controller: class12PercentageController),
          buildInputField(hint: "City", controller: class12CityController),
          buildInputField(hint: "State", controller: class12StateController),
        ]),
      );
    }

    fields.add(
      _buildSection("Higher Secondary (Class 10)", [
        buildInputField(hint: "Board", controller: class10BoardController),
        buildInputField(hint: "School Name", controller: class10SchoolController),
        buildInputField(hint: "Passing Year", controller: class10YearController),
        buildInputField(hint: "Percentage", controller: class10PercentageController),
        buildInputField(hint: "City", controller: class10CityController),
        buildInputField(hint: "State", controller: class10StateController),
      ]),
    );

    return fields;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSection("Education Level", [
          DropdownButtonFormField<String>(
            value: _highestEducation,
            dropdownColor: const Color(0xFF1A1A1A),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.07),
              hintText: "Select Highest Education",
              hintStyle: const TextStyle(color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            items: const [
              DropdownMenuItem(value: "Post-Graduation", child: Text("Post-Graduation")),
              DropdownMenuItem(value: "Graduation", child: Text("Graduation")),
              DropdownMenuItem(value: "Senior Secondary", child: Text("Senior Secondary (12th)")),
              DropdownMenuItem(value: "Higher Secondary", child: Text("Higher Secondary (10th)")),
            ],
            onChanged: (value) {
              setState(() {
                _highestEducation = value;
              });
            },
          ),
        ]),
        ..._educationFields(),
      ],
    );
  }
}
