import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.hgbrasil.com'; // Use a URL correta da API

  Future<Map<String, dynamic>> fetchCotacoes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar as cotações');
    }
  }
}
