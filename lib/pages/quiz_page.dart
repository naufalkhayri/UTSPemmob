import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/quiz_state.dart';
import '../data/questions.dart';
import '../widgets/option_tile.dart';
import '../widgets/app_button.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  static const List<String> _letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizState>();
    final question = kQuestions[quiz.currentIndex];
    final answered = quiz.currentAnswer;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(quiz.name),
        centerTitle: false,
      ),
      body: Center(
        child: ConstrainedBox(
          // Batasi lebar konten supaya rapi di tablet/landscape
          constraints: const BoxConstraints(maxWidth: 680),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header: nomor soal + progress ──────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Soal ${quiz.currentIndex + 1} / ${quiz.totalQuestions}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (quiz.currentIndex + 1) / quiz.totalQuestions,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 24),

                // ── Teks soal ──────────────────────────────────────────────
                Text(
                  question.text,
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600, height: 1.5),
                ),
                const SizedBox(height: 20),

                // ── Pilihan jawaban ────────────────────────────────────────
                ...List.generate(question.options.length, (i) {
                  return OptionTile(
                    letter: _letters[i],
                    text: question.options[i],
                    isSelected: answered == i,
                    onTap: () => context.read<QuizState>().selectAnswer(i),
                  );
                }),
                const SizedBox(height: 28),

                // ── Tombol navigasi ────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Sebelumnya',
                        // nonaktif di soal pertama
                        onPressed: quiz.isFirst
                            ? null
                            : () => context.read<QuizState>().previous(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: quiz.isLast ? 'Selesai' : 'Berikutnya',
                        // nonaktif kalau belum dijawab
                        onPressed: answered == null
                            ? null
                            : () {
                                if (quiz.isLast) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/result',
                                  );
                                } else {
                                  context.read<QuizState>().next();
                                }
                              },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
