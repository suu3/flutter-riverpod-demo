import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/constants/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod_demo/main.dart';
// import 'package:flutter_riverpod_demo/screens/profile.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isLoading = false;
  final bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });

      //supabase 만료로 주석처리
      // await supabase.auth.signInWithOtp(
      //   email: _emailController.text.trim(),
      //   emailRedirectTo: kIsWeb
      //       ? 'https://suu3.github.io/flutter-riverpod-demo/'
      //       : 'io.supabase.flutterquickstart://login-callback/',
      // );
      if (mounted) {
        context.showSnackBar('Check your email for a login link!');

        _emailController.clear();
        context.go(Routes.home);
      }
    } on AuthException catch (error) {
      if (mounted) context.showSnackBar(error.message, isError: true);
    } catch (error) {
      if (mounted) {
        context.showSnackBar('Unexpected error occurred', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // @override
  // void initState() {
  //   _authStateSubscription = supabase.auth.onAuthStateChange.listen(
  //     (data) {
  //       if (_redirecting) return;
  //       final session = data.session;
  //       if (session != null) {
  //         _redirecting = true;
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => const MyProfile()),
  //         );
  //       }
  //     },
  //     onError: (error) {
  //       if (error is AuthException) {
  //         context.showSnackBar(error.message, isError: true);
  //       } else {
  //         context.showSnackBar('Unexpected error occurred', isError: true);
  //       }
  //     },
  //   );
  //   super.initState();
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Sending...' : 'Send Magic Link'),
          ),
        ],
      ),
    );
  }
}
