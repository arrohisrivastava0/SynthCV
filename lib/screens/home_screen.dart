// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:synthcv/resume/manual_resume_form.dart';
// import 'package:synthcv/resume/upload_resume_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final user = Supabase.instance.client.auth.currentUser;
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   final displayName = user?.userMetadata?['full_name'] ?? user?.userMetadata?['name'] ?? 'User';
//   //
//   //   return Scaffold(
//   //     backgroundColor: Colors.black,
//   //     appBar: AppBar(title: Text('Welcome, $displayName')),
//   //     body: const Center(
//   //       child: Text('You are now logged in!',
//   //           style: TextStyle(color: Colors.tealAccent, fontSize: 20)),
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final displayName = user?.userMetadata?['full_name'] ??
//         user?.userMetadata?['name'] ??
//         'User';
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F0F0F),
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF00FFFF), Color(0xFF8A2BE2)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 24),
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.white.withOpacity(0.2)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.4),
//                   blurRadius: 15,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Welcome, $displayName',
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(color: Colors.cyanAccent, blurRadius: 10),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Choose how you want to upload your resume:',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.upload_file, color: Colors.white),
//                   label: const Text(
//                     "Upload Resume (PDF)",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.cyanAccent,
//                     elevation: 10,
//                     side: const BorderSide(color: Colors.cyanAccent),
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UploadResumeScreen()));
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.edit, color: Colors.white),
//                   label: const Text(
//                     "Enter Resume Manually",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     shadowColor: Colors.purpleAccent,
//                     elevation: 10,
//                     side: const BorderSide(color: Colors.purpleAccent),
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ManualResumeForm()));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:synthcv/resume/manual_resume_form.dart';
// import 'package:synthcv/resume/upload_resume_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   final user = Supabase.instance.client.auth.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     final displayName = user?.userMetadata?['full_name'] ??
//         user?.userMetadata?['name'] ??
//         'User';
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D), // Dark background
//       body: Center(
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 24),
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.05),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.white.withOpacity(0.2)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.cyanAccent.withOpacity(0.2),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//               BoxShadow(
//                 color: Colors.deepPurpleAccent.withOpacity(0.2),
//                 blurRadius: 20,
//                 offset: const Offset(0, 10),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Welcome, $displayName',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(color: Colors.cyanAccent, blurRadius: 10),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Choose how you want to upload your resume:',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.upload_file, color: Colors.white),
//                 label: const Text(
//                   "Upload Resume (PDF)",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.cyanAccent,
//                   elevation: 10,
//                   side: const BorderSide(color: Colors.cyanAccent),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => UploadResumeScreen()));
//                 },
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 icon: const Icon(Icons.edit, color: Colors.white),
//                 label: const Text(
//                   "Enter Resume Manually",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.transparent,
//                   shadowColor: Colors.purpleAccent,
//                   elevation: 10,
//                   side: const BorderSide(color: Colors.purpleAccent),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => ManualResumeForm()));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/resume/manual_resume_form.dart';
import 'package:synthcv/resume/upload_resume_screen.dart';

class HomeScreen extends StatelessWidget {
  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    final displayName = user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'] ??
        'User';

    return Scaffold(
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
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03), // darker glassmorphic layer
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome, $displayName',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.cyanAccent, blurRadius: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose how you want to upload your resume:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: const Text(
                    "Upload Resume (PDF)",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.cyanAccent,
                    elevation: 10,
                    side: const BorderSide(color: Colors.cyanAccent),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UploadResumeScreen()));
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Enter Resume Manually",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.purpleAccent,
                    elevation: 10,
                    side: const BorderSide(color: Colors.purpleAccent),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ManualResumeForm()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
