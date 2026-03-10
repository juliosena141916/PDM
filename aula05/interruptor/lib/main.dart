import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InterruptorApp()),  //Primeira pagina a ser carregada
    );
}

class InterruptorApp extends StatefulWidget {
  @override

  _InterruptorAppState createState() => _InterruptorAppState();
}

class _InterruptorAppState extends State<InterruptorApp> {

  int estaAceso = 0;

  void alternarLuz() {
    setState(() {
      estaAceso++;
      if (estaAceso > 2) {
        estaAceso = 0;
      }
    });
  }

  IconData getHumor() {
    if (estaAceso == 0) {
      return Icons.sentiment_very_satisfied;
    } else if (estaAceso == 1) {
      return Icons.sentiment_neutral;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  Color getColor(){
    if (estaAceso == 0) {
      return Colors.green;
    } else if (estaAceso == 1) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor(), // ? operador ternario

      appBar: AppBar( 
        backgroundColor: getColor(),
        title: Text('Emoções',
         style: TextStyle(color: Colors.black,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getHumor(),
              size: 100,
              color: Colors.black,
            ),

            ElevatedButton(
              onPressed: alternarLuz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),

              child: Text(
                'Mudar Emoções',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}