import 'package:flutter/material.dart';
import 'package:flutter_riverpod_demo/constants/routes.dart';
import 'package:flutter_riverpod_demo/screens/profile.dart';
import 'package:flutter_riverpod_demo/screens/home.dart';
import 'package:flutter_riverpod_demo/screens/login.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //supabase
  await Supabase.initialize(
    url: 'https://nocblwmucgpaoopdhssr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5vY2Jsd211Y2dwYW9vcGRoc3NyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTkzNzU4MjQsImV4cCI6MjAzNDk1MTgyNH0.vJoGmR_MUD4rXdJiIlow3yFDnNXYHAAxkmaU8sU4SpA',
  );
  runApp(const ProviderScope(child: MyApp()));
}

final supabase = Supabase.instance.client;

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.login,

    // ** supabase 만료되어 주석처리
    // redirect: (context, state) {
    //   final session = Supabase.instance.client.auth.currentSession;
    //   final loggingIn = state.uri.toString() == Routes.login;

    //   if (session == null && !loggingIn) {
    //     return Routes.login;
    //   } else if (session != null && loggingIn) {
    //     return Routes.home;
    //   }
    //   return null;
    // },
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const MyLogin(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const MyHome(),
      ),
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const MyProfile(),
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

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
