import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: PaginaSorteador()));
}

class PaginaSorteador extends StatefulWidget {
  @override
  _PaginaSorteadorState createState() => _PaginaSorteadorState();
}

class _PaginaSorteadorState extends State<PaginaSorteador> {
  int numeroSorteado = 0;

  void sortear() {
    setState(() {
      numeroSorteado = Random().nextInt(10) + 1; 
    });
  }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorteador de Números")),
      body: Center(
        child: Text("Número sorteado: $numeroSorteado",
        style: TextStyle(fontSize: 30)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sortear,
        child: Icon(Icons.casino),
      ),
    );
  }
}