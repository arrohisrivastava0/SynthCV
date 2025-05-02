import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:async';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  void checkLoginStatus(BuildContext context) {
    var box = Hive.box('loginBox');
    bool rememberMe = box.get('rememberMe', defaultValue: false);
    if (rememberMe) {
      String username = box.get('username');
      String password = box.get('password');
      // Validate credentials or navigate to home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ✅ Using Future.delayed instead of Timer
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // ensures widget is still in tree
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (context, animation, secondaryAnimation) => const Login(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation);
            final fadeAnimation = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        ),
      );
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0A0A), Color(0xFF12172B), Color(0xFF000000)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00FFFF).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: const Color(0xFF8A2BE2).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.description, size: 100, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "SynthCV",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your AI-powered Resume Builder",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//better neon______________________________________________________________________________________________________better neon
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'login.dart'; // Adjust to your actual Login screen file
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.7, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//
//     _controller.forward();
//
//     Timer(const Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         PageRouteBuilder(
//           transitionDuration: const Duration(milliseconds: 800),
//           pageBuilder: (_, __, ___) => const Login(),
//           transitionsBuilder: (_, animation, __, child) {
//             final offsetAnimation = Tween<Offset>(
//               begin: const Offset(0, 1), // Start from bottom
//               end: Offset.zero,          // Slide to original position
//             ).animate(CurvedAnimation(
//               parent: animation,
//               curve: Curves.easeOut,
//             ));
//
//             return SlideTransition(
//               position: offsetAnimation,
//               child: child,
//             );
//           },
//         ),
//       );
//     });


    // Timer(const Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(
    //     PageRouteBuilder(
    //       transitionDuration: const Duration(milliseconds: 800),
    //       pageBuilder: (_, __, ___) => const Login(),
    //       transitionsBuilder: (_, animation, __, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         );
    //       },
    //     ),
    //   );
    //
    //   // Navigator.pushReplacement(
    //   //   context,
    //   //   MaterialPageRoute(builder: (_) => const Login()),
    //   // );
    // });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF00FFFF), Color(0xFF8A2BE2)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: Container(
//                 padding: const EdgeInsets.all(30),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   color: Colors.black.withOpacity(0.6),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.cyanAccent.withOpacity(0.2),
//                       blurRadius: 15,
//                       spreadRadius: 4,
//                       offset: Offset(0, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.purpleAccent.withOpacity(0.2),
//                       blurRadius: 15,
//                       spreadRadius: 4,
//                       offset: Offset(0, 0),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: const [
//                     Icon(Icons.description, size: 100, color: Colors.white),
//                     SizedBox(height: 20),
//                     Text(
//                       "SynthCV",
//                       style: TextStyle(
//                         fontSize: 36,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Your AI-powered Resume Builder",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//___________________________________________________________________________________________

// import 'package:flutter/material.dart';
// import 'package:synthcv/login.dart';
// import 'package:synthcv/styled_login_screen.dart';
// import 'dart:async';
// import 'login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//
//     _controller.forward();
//
//     Timer(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const Login()),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF000428), Color(0xFF004e92)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children:  [
//                   Icon(Icons.description, size: 100, color: Colors.white),
//                   SizedBox(height: 20),
//                   Text(
//                     "SynthCV",
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Your AI-powered Resume Builder",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
