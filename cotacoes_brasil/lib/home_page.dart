import 'api_service.dart';
import 'package:flutter/material.dart';
import 'api_service.dart'; // Certifique-se de que o caminho esteja correto!

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotações de Moedas'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: ApiService().fetchCotacoes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              try {
                final cotacoes = snapshot.data!['results'] as List;
                return ListView.builder(
                  itemCount: cotacoes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cotacoes[index]['name']),
                      subtitle: Text(
                          'Compra: ${cotacoes[index]['buy']} - Venda: ${cotacoes[index]['sell']}'),
                    );
                  },
                );
              } catch (e) {
                return Center(child: Text('Erro ao processar os dados: $e'));
              }
            } else {
              return Center(child: Text('Nenhum dado disponível.'));
            }
          },
        ),
      ),
    );
  }
}
