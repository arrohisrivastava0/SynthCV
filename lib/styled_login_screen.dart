import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/home_screen.dart';
import 'package:synthcv/main.dart';

class StyledLoginScreen extends StatefulWidget {
  const StyledLoginScreen({super.key});

  @override
  State<StyledLoginScreen> createState() => _StyledLoginScreenState();
}

class _StyledLoginScreenState extends State<StyledLoginScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginWithEmail() async{

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
      // _showErrorSnackBar('Email login failed: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010), // Deep charcoal background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              const Text(
                "Go ahead and set up your account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 6),
              const Text(
                "Sign in/up to enjoy the best managing experience",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 32),

              // Login/Register Tab Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tabs: const [
                    Tab(text: "Login"),
                    Tab(text: "Register"),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLoginCard(),
                    _buildRegisterCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 10),

                // Remember me and forgot password
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (val) => setState(() => _rememberMe = val!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    const Text("Remember me"),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password?", style: TextStyle(fontSize: 13)),
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // Login button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Login", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text("Or login with", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),

          // Social login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialLoginButton("assets/google.png", "Google"),
              const SizedBox(width: 12),
              _socialLoginButton("assets/facebook.png", "Facebook"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterCard() {
    return Center(
      child: Text(
        "Register Screen (Coming Soon)",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _socialLoginButton(String iconPath, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(iconPath, height: 20),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}
