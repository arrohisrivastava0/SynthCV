import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/main.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void _loginWithEmail() async{
    setState(() => _isLoading = true);
    final supabase = Supabase.instance.client;

// Email and password sign up
//     await supabase.auth.signUp(
//       email: _emailController.text.trim(),
//       password: _passwordController.text.trim(),
//     );

// Email and password login
    try{
      final response= await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      _showErrorSnackBar('Email login failed: $e');
    }

    await supabase.auth.signInWithPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

// Magic link login
    await supabase.auth.signInWithOtp(email: 'my_email@example.com');

// Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      // Do something when there is an auth event
    });
  }

  Future<void> _loginWithGoogle() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId = '533019427026-obag8emhljtuff02e9e2g1u4mv5hpi2g.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = '533019427026-eljpdsttr86aj85mi3ssopc7p5uekk9q.apps.googleusercontent.com';

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        // ✅ Navigate to HomeScreen on successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: No user data received')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: $e')),
      );
    }

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    // final GoogleSignIn googleSignIn = GoogleSignIn(
    // clientId: iosClientId,
    // serverClientId: webClientId,
    // );
    // final googleUser = await googleSignIn.signIn();
    // final googleAuth = await googleUser!.authentication;
    // final accessToken = googleAuth.accessToken;
    // final idToken = googleAuth.idToken;
    //
    // if (accessToken == null) {
    // throw 'No Access Token found.';
    // }
    // if (idToken == null) {
    // throw 'No ID Token found.';
    // }
    //
    // return supabase.auth.signInWithIdToken(
    // provider: OAuthProvider.google,
    // idToken: idToken,
    // accessToken: accessToken,
    // );





    // try {
    //   await Supabase.instance.client.auth.signInWithOAuth(OAuthProvider.google, redirectTo: 'https://hthievkrcnffgfzzuuye.supabase.co/auth/v1/callback');
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Login failed: $e")),
    //   );
    // }
  }
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ));
  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: ElevatedButton.icon(
//           icon: Icon(Icons.login, color: Colors.white),
//           label: Text('Login with Google', style: TextStyle(color: Colors.white)),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.tealAccent[700],
//             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//           ),
//           onPressed: () => _loginWithGoogle(context),
//         ),
//       ),
//     );
//   }
// }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildGoogleButton() {
    return OutlinedButton.icon(
      onPressed: _loginWithGoogle,
      icon: Image.asset("assets/google.png", height: 24),
      label: const Text("Sign in with Google", style: TextStyle(color: Colors.white)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.black,
//     body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 60),
//             Text(
//               "Welcome to SynthCV",
//               style: TextStyle(
//                 color: Colors.tealAccent,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               "Login to continue",
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 40),
//             TextField(
//               controller: _emailController,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: "Email",
//                 labelStyle: TextStyle(color: Colors.tealAccent),
//                 filled: true,
//                 fillColor: Colors.white10,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 labelStyle: TextStyle(color: Colors.tealAccent),
//                 filled: true,
//                 fillColor: Colors.white10,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _loginWithEmail,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.tealAccent[700],
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Text(
//                   'Login with Email',
//                   style: TextStyle(color: Colors.black, fontSize: 16),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(children: [
//               Expanded(child: Divider(color: Colors.grey)),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text("or", style: TextStyle(color: Colors.white)),
//               ),
//               Expanded(child: Divider(color: Colors.grey)),
//             ]),
//             SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: _loginWithGoogle,
//                 icon: Image.asset('assets/google_logo.png', height: 20),
//                 label: Text(
//                   'Continue with Google',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   side: BorderSide(color: Colors.tealAccent),
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF141E30), Color(0xFF243B55)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Container(
//             padding: const EdgeInsets.all(32),
//             margin: const EdgeInsets.symmetric(horizontal: 24),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.05),
//               borderRadius: BorderRadius.circular(24),
//               border: Border.all(color: Colors.white24),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black54,
//                   blurRadius: 10,
//                   spreadRadius: 1,
//                   offset: Offset(0, 6),
//                 )
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text("Welcome to SynthCV", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 16),
//                 _buildGoogleButton(),
//                 const SizedBox(height: 8),
//                 const Text("Or continue with email", style: TextStyle(color: Colors.white70)),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {}, // Future email login
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//                   child: const Text("Login with Email"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
// }

// @override
// Widget build(BuildContext context) {
//   final theme = Theme.of(context);
//   final screenWidth = MediaQuery.of(context).size.width;
//
//   return Scaffold(
//     backgroundColor: Colors.grey.shade100,
//     body: Center(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text("Welcome Back 👋"),
//             const SizedBox(height: 8),
//             Text("Login to continue using SynthCV"),
//             const SizedBox(height: 32),
//
//             // Email Field
//             TextField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 hintText: 'Email Address',
//                 prefixIcon: Icon(Icons.email_outlined),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//             ),
//             const SizedBox(height: 16),
//
//             // Password Field
//             TextField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 hintText: 'Password',
//                 prefixIcon: Icon(Icons.lock_outline),
//                 suffixIcon: IconButton(
//                   icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
//                   onPressed: _togglePasswordVisibility,
//                 ),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Login Button
//             ElevatedButton(
//               onPressed: _isLoading ? null : _loginWithEmail,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
//             ),
//
//             const SizedBox(height: 24),
//             const Divider(),
//             const SizedBox(height: 16),
//
//             // Google Login
//             OutlinedButton.icon(
//               onPressed: _loginWithGoogle,
//               icon: Image.asset("assets/google.png", height: 24),
//               label: const Text('Sign in with Google'),
//               style: OutlinedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                 side: BorderSide(color: Colors.grey.shade300),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome to SynthCV",
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _loginWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),

                  const Text("Or", style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),

                  // Google Sign-In Button
                  OutlinedButton.icon(
                    onPressed: _loginWithGoogle,
                    icon: Image.asset("assets/google.png", height: 20),
                    label: const Text("Continue with Google", style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white38),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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