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
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await Hive.openBox('loginBox');
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: 'https://hthievkrcnffgfzzuuye.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0aGlldmtyY25mZmdmenp1dXllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1Njg1MzksImV4cCI6MjA2MDE0NDUzOX0.MwJydAWcUVX-wGf4HxQGeD-kJsR2tx0_ZyWA9zm4UuM',
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
      home: const SplashScreen(),
    );
  }
}