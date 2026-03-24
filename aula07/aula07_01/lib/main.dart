import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
     home: TelaInicial()
     ));
}

// Tela 1

class TelaInicial extends StatelessWidget {

  final String nome = "Júlio";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Ir para segunda tela!"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>SegundaTela(nome: nome))
            );
          }
        ),
      ),
    );
  }
}

// Tela 2

class SegundaTela extends StatelessWidget {

  final String nome;

  SegundaTela({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Text("Olá, $nome!, " "Bem vindo a segunda tela!", style: TextStyle(fontSize: 24)),
        ),
      );
  }
}