// Add these imports if not already present
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synthcv/screens/home_screen.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  late TabController _tabController;
  // late AnimationController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    // _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _tabController = TabController(length: 2, vsync: this);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  void _togglePasswordVisibility() {
    setState(() => _isPasswordVisible = !_isPasswordVisible);
  }

  Future<void> _loginWithEmail() async {
    setState(() => _isLoading = true);
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (response.user != null) {
        saveLoginState(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _rememberMe,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } catch (e) {
      if (e.toString().contains('Invalid login credentials')) {
        _showErrorSnackBar('Invalid email or password');
      } else {
        _showErrorSnackBar('Login failed: $e');
      }
    }

    setState(() => _isLoading = false);
  }

  Future<void> _loginWithGoogle() async {
    // Replace with your actual client IDs
    const webClientId = '533019427026-obag8emhljtuff02e9e2g1u4mv5hpi2g.apps.googleusercontent.com';
    const iosClientId = '533019427026-eljpdsttr86aj85mi3ssopc7p5uekk9q.apps.googleusercontent.com';

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final accessToken = googleAuth?.accessToken;
      final idToken = googleAuth?.idToken;

      if (accessToken == null || idToken == null) throw 'Missing Google token';

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user != null) {
        saveLoginState(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          true,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        _showErrorSnackBar('Google login failed');
      }
    } catch (e) {
      _showErrorSnackBar('Login error: $e');
    }
  }

  Future<void> _registerWithEmail() async {
    setState(() => _isLoading = true);
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'name': _nameController.text.trim(),
        },
      );
      if (response.user != null) {
        final box = Hive.box('loginBox');
        box.put('rememberMe', true);
        box.put('loginType', 'google'); // mark the type of login
        saveLoginState(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _rememberMe,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } catch (e) {
      _showErrorSnackBar('Email registration failed: $e');
    }

    setState(() => _isLoading = false);
  }

  void saveLoginState(String username, String password, bool rememberMe) {
    var box = Hive.box('loginBox');
    box.put('rememberMe', rememberMe);
    if (rememberMe) {
      box.put('username', username);
      box.put('password', password); // Note: not secure for sensitive info
    } else {
      box.delete('username');
      box.delete('password');
    }
  }



  @override
  void dispose() {
    // _controller.dispose();
    _fadeController.dispose(); // Add this
    super.dispose();
  }


  Widget _buildInputField({required IconData icon, required String hint, required TextEditingController controller, bool obscure = false, Widget? suffix}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    );
  }


  Widget _buildLoginCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Outer padding to prevent glow clipping
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xFF00FFFF), Color(0xFF8A2BE2)], // Cyan to purple
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 5,
                offset: Offset(0, 0), // Uniform glow
              ),
              BoxShadow(
                color: const Color(0xFF8A2BE2).withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 5,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(1.5), // Thin border look
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1E1E1E).withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 0), // Soft ambient shadow, not just bottom
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputField(
                  icon: Icons.email,
                  hint: "Email Address",
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  icon: Icons.lock,
                  hint: "Password",
                  controller: _passwordController,
                  obscure: !_isPasswordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.tealAccent, fontSize: 12),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (val) => setState(() => _rememberMe = val!),
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                    ),
                    const Text("Remember me", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: _isLoading ? null : _loginWithEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0f3f6e),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: Image.asset("assets/google.png", height: 20),
                  label: const Text("Continue with Google", style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Outer padding to prevent glow clipping
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xFF00FFFF), Color(0xFF8A2BE2)], // Cyan to purple
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 5,
                offset: Offset(0, 0), // Uniform glow
              ),
              BoxShadow(
                color: const Color(0xFF8A2BE2).withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 5,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(1.5), // Thin border look
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF1E1E1E).withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 0), // Soft ambient shadow, not just bottom
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputField(
                  icon: Icons.person,
                  hint: "Full Name",
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  icon: Icons.email,
                  hint: "Email Address",
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  icon: Icons.lock,
                  hint: "Password",
                  controller: _passwordController,
                  obscure: !_isPasswordVisible,
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (val) => setState(() => _rememberMe = val!),
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                    ),
                    const Text("Remember me", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: _isLoading ? null : _registerWithEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0f3f6e),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Register", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: Image.asset("assets/google.png", height: 20),
                  label: const Text("Continue with Google", style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0A0A), Color(0xFF12172B), Color(0xFF000000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        // vsync: this,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 60,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Go ahead and set up\nyour account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sign in/up to enjoy the best experience",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,

                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00FFFF), Color(0xFF7A00FF)],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: const Text("Login"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          child: const Text("Register"),
                        ),
                      ),
                    ],

                  ),
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: SizedBox(
                    key: ValueKey(_tabController.index),
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildLoginCard(),
                        _buildRegisterCard(),
                      ],
                    ),
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
