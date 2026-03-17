import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: JogoApp()));
}

class JogoApp extends StatefulWidget {
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {
  IconData iconeComputador = Icons.computer;
  String resultado = "Escolha uma opção";
  int pontosJogador = 0;
  int pontosComputador = 0;
  List<String> opcoes = ["pedra", "papel", "tesoura"];

  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      resultado = "Escolha uma opção";
      iconeComputador = Icons.computer;
    });
  }

  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3);
    var escolhaComputador = opcoes[numero];

    setState(() {
      // Atualiza o ícone do computador
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape;
      } else if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      } else {
        iconeComputador = Icons.content_cut;
      }

      // Lógica do jogo
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate";
      } else if ((escolhaUsuario == "pedra" &&
              escolhaComputador == "tesoura") ||
          (escolhaUsuario == "papel" && escolhaComputador == "pedra") ||
          (escolhaUsuario == "tesoura" && escolhaComputador == "papel")) {
        pontosJogador++;
        resultado = "Você venceu!";
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";
      }
      if (pontosJogador == 5) {
        resultado = "Você ganhou o campeonato!";
        pontosJogador = 0;
        pontosComputador = 0;
      }
      if (pontosComputador == 5) {
        resultado = "Computador ganhou o campeonato!";
        pontosJogador = 0;
        pontosComputador = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedra Papel Tesoura")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Computador"),
            Icon(iconeComputador, size: 100),
            SizedBox(height: 10),
            Text(resultado, style: TextStyle(fontSize: 26)),
            SizedBox(height: 10),
            Text("Você: $pontosJogador | PC: $pontosComputador"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.landscape),
                  onPressed: () => jogar("pedra"),
                ),
                IconButton(
                  icon: Icon(Icons.pan_tool),
                  onPressed: () => jogar("papel"),
                ),
                IconButton(
                  icon: Icon(Icons.content_cut),
                  onPressed: () => jogar("tesoura"),
                ),
                ElevatedButton.icon(
                  onPressed: resetarPlacar,
                  icon: Icon(Icons.refresh),
                  label: Text("Resetar Placar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
