import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/quiz_state.dart';
import '../widgets/app_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
              vertical: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.emoji_events_rounded,
                  size: 80,
                  color: Colors.amber,
                ),
                const SizedBox(height: 24),

                // Nama pengguna
                Text(
                  'Selamat, ${quiz.name}!',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                Text(
                  'Kamu telah menyelesaikan kuis.',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Kartu skor
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal: 40,
                    ),
                    child: Column(
                      children: [
                        Text('Skor Akhir', style: textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Text(
                          'Skor: ${quiz.score} / ${quiz.totalQuestions}',
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Tombol main ulang
                AppButton(
                  label: 'Main Lagi',
                  onPressed: () {
                    context.read<QuizState>().reset();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
