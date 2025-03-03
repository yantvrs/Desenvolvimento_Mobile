import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> filmes = [
    {
      'titulo': 'Interestelar',
      'ano': 2014,
      'direcao': 'Christopher Nolan',
      'resumo':
          'Uma equipe viaja pelo espaço para encontrar um novo lar para a humanidade.',
      'url_cartaz':
          'https://image.tmdb.org/t/p/w500/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg',
      'nota': 4.5,
      'expandido': false,
    },
    {
      'titulo': 'A Origem',
      'ano': 2010,
      'direcao': 'Christopher Nolan',
      'resumo': 'Um ladrão entra nos sonhos das pessoas para roubar segredos.',
      'url_cartaz': '',
      'nota': 4.7,
      'expandido': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Filmes',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.5),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red, // Fundo vermelho
        elevation: 5, // Sombra na parte inferior do AppBar
        centerTitle: true, // Centralizar o título
        toolbarHeight: 60, // Aumentar a altura do AppBar
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: filmes.length,
          itemBuilder: (context, index) {
            final filme = filmes[index];
            return GestureDetector(
              onTap: () {
                // Navegar para tela de detalhes (futuramente)
              },
              onLongPress: () {
                setState(() {
                  filmes.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Filme removido!')),
                );
              },
              child: Card(
                color: Colors.grey[850],
                elevation: 8, // Sombra para dar um aspecto mais moderno
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16), // Bordas arredondadas
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagem do Cartaz
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              16)), // Bordas arredondadas na imagem
                      child: filme['url_cartaz'] != null &&
                              filme['url_cartaz']!.isNotEmpty
                          ? Image.network(
                              filme['url_cartaz'],
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 220,
                              width: double.infinity,
                              color: Colors.grey[700],
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título e Ano do Filme
                          Text(
                            filme['titulo'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${filme['ano']} - ${filme['direcao']}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Descrição curta
                          Text(
                            filme['resumo'],
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Previne overflow do texto
                            maxLines: 2, // Limita o número de linhas
                          ),
                          SizedBox(height: 8),
                          // Avaliação
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                filme['nota'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Navegar para tela de cadastro (futuramente)
        },
      ),
    );
  }
}
