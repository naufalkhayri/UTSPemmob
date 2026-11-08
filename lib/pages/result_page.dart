import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/questions.dart';
import '../state/quiz_state.dart';
import '../widgets/app_button.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

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
    final answers = quiz.selectedAnswers;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // Batasi lebar konten di layar lebar (tablet/landscape)
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Ikon dinamis sesuai skor
                  Icon(feedback.icon, size: iconSize, color: feedback.color),
                  const SizedBox(height: 24),

                  // Nama pengguna — sapaan menyesuaikan skor
                  Text(
                    percent >= 0.50
                        ? 'Selamat, ${quiz.name}!'
                        : 'Semangat, ${quiz.name}!',
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Pesan dinamis
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
                      padding: EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Column(
                        children: [
                          Text('Skor Akhir', style: textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text(
                            '${quiz.score} / ${quiz.totalQuestions}',
                            style: textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // ── Ringkasan jawaban ─────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ringkasan Jawaban',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: kQuestions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final question = kQuestions[i];
                      final chosen = answers[i];
                      final isCorrect = chosen == question.answerIndex;

                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isCorrect
                                ? Colors.green.shade300
                                : Colors.red.shade300,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Ikon benar / salah
                              Icon(
                                isCorrect
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel_rounded,
                                color: isCorrect
                                    ? Colors.green
                                    : Colors.redAccent,
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Teks soal — ditampilkan penuh
                                    Text(
                                      '${i + 1}. ${question.text}',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Jawaban pengguna
                                    Text(
                                      'Jawabanmu: ${chosen != null ? question.options[chosen] : 'Tidak dijawab'}',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: isCorrect
                                            ? Colors.green.shade700
                                            : Colors.red.shade700,
                                      ),
                                    ),

                                    // Jawaban benar (hanya tampil kalau salah)
                                    if (!isCorrect)
                                      Text(
                                        'Jawaban benar: ${question.options[question.answerIndex]}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: Colors.green.shade700,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),

                  // Tombol ulangi kuis
                  AppButton(
                    label: 'Ulangi Kuis',
                    onPressed: () {
                      context.read<QuizState>().reset();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
