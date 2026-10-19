// Model dan data soal kuis

class Question {
  final String text;
  final List<String> options;
  final int answerIndex; // indeks jawaban benar di dalam options

  const Question({
    required this.text,
    required this.options,
    required this.answerIndex,
  });
}

const List<Question> kQuestions = [
  Question(
    text: 'Apa bahasa pemrograman yang digunakan Flutter?',
    options: ['Kotlin', 'Swift', 'Dart', 'JavaScript'],
    answerIndex: 2,
  ),
  Question(
    text: 'Widget mana yang TIDAK menyimpan state?',
    options: [
      'StatefulWidget',
      'StatelessWidget',
      'InheritedWidget',
      'Provider',
    ],
    answerIndex: 1,
  ),
  Question(
    text: 'Method apa yang wajib di-override pada StatelessWidget?',
    options: ['initState()', 'build()', 'dispose()', 'setState()'],
    answerIndex: 1,
  ),
  Question(
    text: 'Apa fungsi setState() pada StatefulWidget?',
    options: [
      'Menghapus widget dari tree',
      'Menginisialisasi state awal',
      'Memberitahu Flutter untuk rebuild widget',
      'Mengambil data dari API',
    ],
    answerIndex: 2,
  ),
  Question(
    text: 'Package apa yang digunakan untuk state management di proyek ini?',
    options: ['Riverpod', 'Bloc', 'Provider', 'GetX'],
    answerIndex: 2,
  ),
  Question(
    text: 'Tipe data Dart mana yang digunakan untuk koleksi key-value?',
    options: ['List', 'Set', 'Map', 'Queue'],
    answerIndex: 2,
  ),
  Question(
    text: 'Widget apa yang digunakan agar child mengisi sisa ruang pada Row/Column?',
    options: ['Padding', 'Center', 'Expanded', 'Align'],
    answerIndex: 2,
  ),
  Question(
    text: 'Keyword apa yang digunakan untuk membuat fungsi asinkron di Dart?',
    options: ['async', 'await', 'future', 'then'],
    answerIndex: 0,
  ),
];
