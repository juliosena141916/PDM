import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

//Tela 1 – Lista de Contatos

class TelaInicial extends StatelessWidget {

  final List<Map<String, String>> contatos = [
    {"nome": "João Silva", "telefone": "11999999999"},
    {"nome": "Maria Souza", "telefone": "11888888888"},
    {"nome": "Carlos Lima", "telefone": "11777777777"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final nome = contatos[index]["nome"]!;
          final telefone = contatos[index]["telefone"]!;

          return ListTile(
            title: Text(nome),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheContato(
                    nome: nome,
                    telefone: telefone,
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}

//Tela 2 – Detalhes

class DetalheContato extends StatelessWidget {

  final String nome;
  final String telefone;

  DetalheContato({required this.nome, required this.telefone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhe do Contato'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nome,
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 10),

            Text(
              "$telefone",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Voltar"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}