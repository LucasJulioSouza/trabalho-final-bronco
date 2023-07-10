import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditarLivrosPage extends StatefulWidget {
  final String livroId;
  final String titulo;
  final String conteudo;
  final String autor;

  const EditarLivrosPage({
    required this.livroId,
    required this.titulo,
    required this.conteudo,
    required this.autor,
  });

  @override
  _EditarLivrosPageState createState() => _EditarLivrosPageState();
}

class _EditarLivrosPageState extends State<EditarLivrosPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tituloController.text = widget.titulo;
    _conteudoController.text = widget.conteudo;
    _autorController.text = widget.autor;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    _autorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Livro'),
        
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
                _editarLivro(context);
              },
              child: const Text('Editar Livro'),
            ),
          ],
        ),
      ),
    );
  }

  void _editarLivro(BuildContext context) {
  final String novoTitulo = _tituloController.text;
  final String novoConteudo = _conteudoController.text;
  final String novoAutor = _autorController.text;

  FirebaseFirestore.instance
      .collection('livros')
      .doc(widget.livroId)
      .update({
        'titulo': novoTitulo,
        'conteudo': novoConteudo,
        'autor': novoAutor,
      })
      .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Livro atualizado com sucesso!'),
          ),
        );
      })
      .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Erro ao atualizar o livro. Tente novamente.'),
          ),
        );
      });
}

  
}