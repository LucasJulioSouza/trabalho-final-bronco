import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../authentication/external/services/LivrosCrudService.dart';
import 'CadastroLivroPage.dart';
import 'EditarLivrosPage.dart';

class ListaLivros extends StatefulWidget {
  @override
  _ListaLivrosState createState() => _ListaLivrosState();
}

class _ListaLivrosState extends State<ListaLivros> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage("https://seeklogo.com/images/I/ifpr-instituto-federal-do-parana-icone-logo-E4B5B3D67E-seeklogo.com.png"),
            ),
            SizedBox(width: 16),
            Text(
              'Biblioteca IFPR',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('livros').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum livro cadastrado.'));
          }
          final List<QueryDocumentSnapshot> books = snapshot.data!.docs;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final String titulo = book['titulo'] as String;
              final String conteudo = book['conteudo'] as String;
              final String autor = book['autor'] as String;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      titulo,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conteúdo: $conteudo',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          'Autor: $autor',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarLivrosPage(
                                  livroId: book.id,
                                  titulo: titulo,
                                  conteudo: conteudo,
                                  autor: autor,
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () {
                            
                            final LivrosCrudService _livrosCrudService = LivrosCrudService();
                            _livrosCrudService.deletarLivro(context, book.id);
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroLivroPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  
}