import 'package:flutter/material.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/services/livrosCrudService.dart';

class CadastroLivroPage extends StatelessWidget {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Livros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _conteudoController,
              decoration: const InputDecoration(labelText: 'Conteúdo'),
            ),
            TextField(
              controller: _autorController,
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
            ElevatedButton(
              onPressed: () {
                LivrosCrudService livrosCrudService = LivrosCrudService();
                livrosCrudService.cadastrarLivro(context,_tituloController,
      _conteudoController,
      _autorController,);
              },
              child: const Text('Cadastrar Livro'),
            ),
          ],
        ),
      ),
    );
  }
}
