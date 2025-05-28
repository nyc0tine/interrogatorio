import 'package:flutter/material.dart';

class AnswerPage extends StatelessWidget {
  final int respostasSim;
  const AnswerPage({super.key, required this.respostasSim});

  String getResultado() {
    if (respostasSim <= 1) {
      return "Inocente";
    } else if (respostasSim == 2) {
      return "Suspeito";
    } else if (respostasSim <= 4) {
      return "Cúmplice";
    } else {
      return "Assassino";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar
        title: const Text('Resultado'),
        backgroundColor: const Color.fromARGB(255, 114, 185, 233),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              getResultado(),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 140,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 117, 193, 228),
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 24),
                ),
                child: const Text('Reiniciar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}