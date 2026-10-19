import 'package:flutter/foundation.dart';

import '../data/questions.dart';

class QuizState extends ChangeNotifier {
  String _name = '';
  int _currentIndex = 0;
  // Menyimpan jawaban yang dipilih per soal; null = belum dijawab
  final List<int?> _selectedAnswers = List.filled(kQuestions.length, null);

  // ── Getters ────────────────────────────────────────────────────────────────

  String get name => _name;
  int get currentIndex => _currentIndex;
  List<int?> get selectedAnswers => List.unmodifiable(_selectedAnswers);
  int get totalQuestions => kQuestions.length;
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == kQuestions.length - 1;

  /// Jumlah jawaban benar dari semua soal yang sudah dijawab
  int get score {
    int count = 0;
    for (int i = 0; i < kQuestions.length; i++) {
      if (_selectedAnswers[i] == kQuestions[i].answerIndex) count++;
    }
    return count;
  }

  /// Jawaban yang dipilih untuk soal saat ini (null jika belum)
  int? get currentAnswer => _selectedAnswers[_currentIndex];

  // ── Methods ────────────────────────────────────────────────────────────────

  /// Menyimpan nama pengguna yang diinput di halaman awal
  void setName(String value) {
    _name = value.trim();
    notifyListeners();
  }

  /// Menyimpan pilihan jawaban pengguna untuk soal saat ini
  void selectAnswer(int optionIndex) {
    _selectedAnswers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  /// Pindah ke soal berikutnya (tidak melewati batas terakhir)
  void next() {
    if (!isLast) {
      _currentIndex++;
      notifyListeners();
    }
  }

  /// Kembali ke soal sebelumnya (tidak melewati batas pertama)
  void previous() {
    if (!isFirst) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Mereset seluruh state ke kondisi awal (untuk main ulang)
  void reset() {
    _name = '';
    _currentIndex = 0;
    _selectedAnswers.fillRange(0, _selectedAnswers.length, null);
    notifyListeners();
  }
}
