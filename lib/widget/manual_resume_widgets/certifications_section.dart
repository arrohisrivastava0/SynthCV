import 'package:flutter/material.dart';
import 'package:synthcv/widget/buildInputField.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({Key? key}) : super(key: key);
  @override
  CertificationsSectionState createState() => CertificationsSectionState();
}

class CertificationsSectionState extends State<CertificationsSection> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  List<Map<String, TextEditingController>> _certifications = [];

  void _addCertification() {
    setState(() {
      _certifications.add({
        "name": TextEditingController(),
        "monthYear": TextEditingController(),
        "link": TextEditingController(),
      });
    });
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

  List<Map<String, String>> getCertifications() {
    return _certifications.map((cert) {
      return {
        "name": cert["name"]?.text.trim() ?? '',
        "monthYear": cert["monthYear"]?.text.trim() ?? '',
        "link": cert["link"]?.text.trim() ?? '',
      };
    }).where((c) => c.values.any((value) => value.isNotEmpty)).toList();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ..._certifications.asMap().entries.map((entry) {
          int index = entry.key;
          var cert = entry.value;
          return _section("Certification ${index + 1}", [
            buildInputField(hint: "Certification Name", controller: cert["name"]!),
            buildInputField(hint: "Month & Year", controller: cert["monthYear"]!),
            buildInputField(hint: "Validation Link", controller: cert["link"]!),
          ]);
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: _addCertification,
            icon: const Icon(Icons.add, color: Colors.cyanAccent),
            label: const Text("Add Certification", style: TextStyle(color: Colors.cyanAccent)),
          ),
        ),
      ],
    );
  }
}
