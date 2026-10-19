import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/quiz_state.dart';
import '../widgets/app_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  // Tentukan ikon, warna, dan pesan berdasarkan persentase skor
  _ResultFeedback _getFeedback(double percent) {
    if (percent >= 0.75) {
      return _ResultFeedback(
        icon: Icons.emoji_events_rounded,
        color: Colors.amber,
        message: 'Luar biasa! Kamu menguasai materi ini dengan sangat baik.',
      );
    } else if (percent >= 0.50) {
      return _ResultFeedback(
        icon: Icons.thumb_up_rounded,
        color: Colors.blue,
        message: 'Bagus! Terus semangat belajar Flutter dan Dart.',
      );
    } else {
      return _ResultFeedback(
        icon: Icons.refresh_rounded,
        color: Colors.redAccent,
        message: 'Jangan menyerah! Coba lagi dan pelajari materinya.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final textTheme = Theme.of(context).textTheme;
    final iconSize = MediaQuery.of(context).size.shortestSide * 0.22;
    final percent = quiz.totalQuestions == 0
        ? 0.0
        : quiz.score / quiz.totalQuestions;
    final feedback = _getFeedback(percent);

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
                // Ikon dinamis sesuai skor
                Icon(feedback.icon, size: iconSize, color: feedback.color),
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

                // Pesan dinamis sesuai skor
                Text(
                  feedback.message,
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

// Data class sederhana untuk bundel ikon + warna + pesan
class _ResultFeedback {
  final IconData icon;
  final Color color;
  final String message;

  const _ResultFeedback({
    required this.icon,
    required this.color,
    required this.message,
  });
}
