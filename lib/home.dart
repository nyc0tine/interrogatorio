import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'answer.dart'; // Adicione esta linha no topo, junto com os outros imports

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<String> perguntas = [
    "Telefonou para a vítima?",
    "Esteve no local do crime?",
    "Mora perto da vítima?",
    "Devia para a vítima?",
    "Já trabalhou com a vítima?"
  ];

  int perguntaAtual = 0;
  int respostasSim = 0;

  void responder(bool sim) async {
    if (sim) respostasSim++;
    if (perguntaAtual < perguntas.length - 1) {
      setState(() {
        perguntaAtual++;
      });
    } else {
      // Salva o total de respostas "Sim" nas preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('respostas_sim', respostasSim);

      // Navega para a AnswerPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnswerPage(respostasSim: respostasSim),
        ),
      ).then((_) {
        // Reinicia ao voltar da AnswerPage
        setState(() {
          perguntaAtual = 0;
          respostasSim = 0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interrogatório'), 
        backgroundColor: const Color.fromARGB(255, 114, 185, 233),), 
        
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 246, 252, 255),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color.fromARGB(255, 167, 215, 255), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                perguntas[perguntaAtual],
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 100,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => responder(true),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24),
                    backgroundColor: const Color.fromARGB(255, 117, 193, 228),
                    foregroundColor: Colors.black, // cor do texto azul escuro
                  ),
                  child: const Text('Sim'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 100,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => responder(false),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24),
                    backgroundColor: const Color.fromARGB(255, 117, 193, 228),
                    foregroundColor: Colors.black, // cor do texto azul escuro
                  ),
                  child: const Text('Não'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}