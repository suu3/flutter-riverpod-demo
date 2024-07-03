import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/constants/routes.dart';
import 'package:flutter_riverpod_demo/screens/home.dart';
import 'package:flutter_riverpod_demo/screens/login.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const MyHome(),
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter RiverPod Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 179, 143, 255),
        scaffoldBackgroundColor: const Color.fromARGB(255, 232, 232, 232),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF232323)),
          bodyMedium: TextStyle(color: Color(0xFF232323)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 179, 143, 255),
          // titleTextStyle: TextStyle(color: Color(0xFF232323), fontSize: 20),
        ),
      ),
      routerConfig: router(),
    );
  }
}
