import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> filmes = [];

  @override
  void initState() {
    super.initState();
    _loadFilmes();
  }

  void _loadFilmes() async {
    final db = DatabaseHelper();
    final filmesList = await db.getFilmes();
    setState(() {
      filmes = filmesList;
    });
  }

  void _adicionarFilme(Map<String, dynamic> novoFilme) async {
    final db = DatabaseHelper();
    await db.insertFilme(novoFilme);
    _loadFilmes();
  }

  void _editarFilme(Map<String, dynamic> filme) async {
    final db = DatabaseHelper();
    await db.updateFilme(filme);
    _loadFilmes();
  }

  void _removerFilme(int id) async {
    final db = DatabaseHelper();
    await db.deleteFilme(id);
    _loadFilmes();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Filme removido!')));
  }

  bool _isValidImageUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Filmes',
          style: TextStyle(
              color: Colors.white, fontFamily: 'BebasNeue', fontSize: 40),
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: filmes.isEmpty
            ? Center(
                child: Text(
                  'Não há filmes disponíveis.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: filmes.length,
                itemBuilder: (context, index) {
                  final filme = filmes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroScreen(
                            filme: filme,
                            onFilmeAdicionado: _editarFilme,
                          ),
                        ),
                      );
                    },
                    onLongPress: () => _removerFilme(filme['id']),
                    child: Card(
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            child: _isValidImageUrl(filme['url_cartaz'])
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
                                Text(
                                  filme['resumo'],
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 8),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroScreen(
                onFilmeAdicionado: _adicionarFilme,
              ),
            ),
          );
        },
      ),
    );
  }
}
