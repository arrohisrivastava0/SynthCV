// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Supabase.initialize(
//     url: 'https://<your-project-ref>.supabase.co',
//     anonKey: 'your-anon-key',
//   );
//   runApp(MyApp());
// }

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/auth/login.dart';
import 'package:synthcv/screens/ats_analysis.dart';
import 'package:synthcv/screens/ats_analysis_screen.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox('loginBox');
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['URL']!, anonKey: dotenv.env['ANON_KEY']!
    );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;



class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SynthCV',
//       theme: ThemeData.dark(useMaterial3: true),
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SynthCV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        fontFamily: 'Montserrat',
      ),
      home: const ATSAnalysis(score: {},),
    );
  }
}