import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your Username',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your Password',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.go('/home'); // 로그인 성공 시 list 화면으로 이동
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Divider(color: Color(0xFF232323))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('or'),
                ),
                Expanded(child: Divider(color: Color(0xFF232323))),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/google_logo.png', height: 24),
              label: const Text('Login with Google'),
            ),
            const SizedBox(height: 16),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   icon: const Icon(Icons.apple, color: Color(0xFF232323)),
            //   label: const Text('Login with Apple'),
            // ),
            // const Spacer(),
            // Center(
            //   child: RichText(
            //     text: const TextSpan(
            //       text: "Don't have an account? ",
            //       style: TextStyle(color: Color(0xFF232323)),
            //       children: <TextSpan>[
            //         TextSpan(
            //           text: 'Register',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
