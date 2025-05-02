import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    final displayName = user?.userMetadata?['full_name'] ?? user?.userMetadata?['name'] ?? 'User';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Welcome, $displayName')),
      body: const Center(
        child: Text('You are now logged in!',
            style: TextStyle(color: Colors.tealAccent, fontSize: 20)),
      ),
    );
  }
}

