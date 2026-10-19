import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/quiz_state.dart';
import 'pages/home_page.dart';
import 'pages/quiz_page.dart';
import 'pages/result_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => QuizState(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Flutter',
      debugShowCheckedModeBanner: false,
      // themeMode siap untuk dark mode nanti
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'PlusJakartaSans',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        fontFamily: 'PlusJakartaSans',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/quiz': (_) => const QuizPage(),
        '/result': (_) => const ResultPage(),
      },
    );
  }
}
