import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TodoPage()));
}

class Atividade extends StatelessWidget {
  const Atividade({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  final List<String> atividade = [];
  final atividadeController = TextEditingController();

  void adicionarTarefa() {
    setState(() {
      atividade.add(atividadeController.text);
    });
    atividadeController.clear();
  }

  void removerTarefa(int index) {
    setState(() {
      atividade.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atividade")
      ),
      body: Column(
        children: [
          TextField(
            controller: atividadeController,  
          ),

          ElevatedButton(
            onPressed: adicionarTarefa,
            child: const Text("Adicionar"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: atividade.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(atividade[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removerTarefa(index),
                  )
                );
              },
            ),
          ),
        ],
        
      ),
      
    );
  }
}
