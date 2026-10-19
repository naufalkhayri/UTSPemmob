import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/quiz_state.dart';
import '../widgets/app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_formKey.currentState!.validate()) {
      context.read<QuizState>().setName(_controller.text);
      Navigator.pushNamed(context, '/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Scroll supaya tidak overflow saat keyboard muncul / layar dirotasi
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,
            vertical: size.height * 0.04,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gambar ilustrasi
                Image.asset(
                  'assets/images/study.png',
                  height: size.height * 0.28,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: size.height * 0.03),

                // Judul
                Text(
                  'Quiz Flutter',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  'Uji pengetahuan dasar Flutter & Dart kamu!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: size.height * 0.04),

                // Input nama
                TextFormField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nama kamu',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.03),

                // Tombol mulai
                AppButton(label: 'Mulai Kuis', onPressed: _start),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
