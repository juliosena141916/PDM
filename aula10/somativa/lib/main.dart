import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppLista(),
  ));
}

class AppLista extends StatefulWidget {
  @override
  _AppListaState createState() => _AppListaState();
}

class _AppListaState extends State<AppLista>{
  TextEditingController controller = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  
  List<Map<String, dynamic>> dados = [];

  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = p.join(caminho, "lista.db");

    return openDatabase(
      path,
      onCreate: (db, Version) {
        return db.execute(
          "CREATE TABLE dados(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT)",
        );  
      },
      version: 1,
    );
  }

  Future<void> inserirDado(String titulo, String descricao) async {
    final db = await criarBanco();

    await db.insert(
      "dados",
      {"titulo":titulo, "descricao": descricao});

    carregarDados();  
  }

  Future<void> carregarDados() async {
    final db = await criarBanco();

    final listadados = await db.query("dados", orderBy: "titulo ASC");

    setState(() {
      dados = listadados;
    });
  }

  Future<void> deletarDados(int id) async {
    final db = await criarBanco();

    await db.delete(
      "dados",
      where: "id = ?",
      whereArgs: [id],
    );

    carregarDados();
  }

  Future<void> atualizarDado(int id, String novoTitulo, String novaDescricao) async {
  final db = await criarBanco();

  await db.update(
    "dados",
    {
      "titulo": novoTitulo,
      "descricao": novaDescricao,
    },
    where: "id = ?",
    whereArgs: [id],
  );

  carregarDados();
}

void mostrarDialogoEdicao(Map<String, dynamic> item) {
    TextEditingController edtTitulo = TextEditingController(text: item["titulo"]);
    TextEditingController edtDescricao = TextEditingController(text: item["descricao"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Registro"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: edtTitulo, decoration: InputDecoration(labelText: "Título")),
              TextField(controller: edtDescricao, decoration: InputDecoration(labelText: "Descrição")),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                atualizarDado(item["id"], edtTitulo.text, edtDescricao.text);
                Navigator.pop(context);
              },
              child: Text("Atualizar"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Banco de Dados")),
      body: Column(
        children: [

         Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Novo Dado",
                border: OutlineInputBorder(),
              ),
            ),
         ),

         Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controllerDescricao,
              decoration: InputDecoration(
                labelText: "Descrição do Dado",
                border: OutlineInputBorder(),
              ),
            ),
         ),

         ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              inserirDado(controller.text, controllerDescricao.text);
              controller.clear();
            };
          },
          child: Text("Salvar"),
         ),

         Expanded(
          child: ListView.builder(
            itemCount: dados.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(dados[index]["titulo"]),
                subtitle: Text(dados[index]["descricao"]),
               
                onTap: () {
                    mostrarDialogoEdicao(dados[index]);
                  },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){
                    deletarDados(dados[index]["id"]);
                  },
                ),
              );
            },
          ),
         ),

        ],
      ),
    );
  }
}
