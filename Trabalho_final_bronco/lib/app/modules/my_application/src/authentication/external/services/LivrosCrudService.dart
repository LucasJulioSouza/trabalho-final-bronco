import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../views/ListaLivros.dart';

class LivrosCrudService {
  void cadastrarLivro(
    BuildContext context,
    TextEditingController tituloController,
    TextEditingController conteudoController,
    TextEditingController autorController,
  ) {
    final String titulo = tituloController.text;
    final String conteudo = conteudoController.text;
    final String autor = autorController.text;

    FirebaseFirestore.instance
        .collection('livros')
        .add({
          'titulo': titulo,
          'conteudo': conteudo,
          'autor': autor,
        })
        .then((value) {
  
          tituloController.clear();
          conteudoController.clear();
          autorController.clear();
         
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Livro cadastrado com sucesso!'),
            ),
          );
          _navigateToBookList(context); 
        })
        .catchError((error) {
         
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  const Text('Erro ao cadastrar o livro. Tente novamente.'),
            ),
          );
        });
  }

  Future<void> deletarLivro(BuildContext context, String livroId) async {
    try {
      await FirebaseFirestore.instance
          .collection('livros')
          .doc(livroId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Livro excluído com sucesso!'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir o livro. Tente novamente.'),
        ),
      );
    }
  }

  

  void _navigateToBookList(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListaLivros()),
      );
    });
  }
}


