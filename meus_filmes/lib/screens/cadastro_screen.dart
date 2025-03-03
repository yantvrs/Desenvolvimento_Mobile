import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilmeAdicionado;

  CadastroScreen({required this.onFilmeAdicionado});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _direcaoController = TextEditingController();
  final TextEditingController _resumoController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  double _nota = 3.0;

  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> novoFilme = {
        'titulo': _tituloController.text,
        'ano': int.parse(_anoController.text),
        'direcao': _direcaoController.text,
        'resumo': _resumoController.text,
        'url_cartaz': _urlController.text,
        'nota': _nota,
        'expandido': false,
      };

      widget.onFilmeAdicionado(novoFilme);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar Filme',
          style: TextStyle(
            color: Colors.white, // Define o texto como branco
          ),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o título do filme' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _anoController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Ano',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o ano de lançamento' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _direcaoController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Diretor',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o diretor do filme' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _resumoController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Resumo',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Informe um resumo do filme' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _urlController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'URL do Cartaz',
                  labelStyle: TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Nota:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: _nota,
                min: 0,
                max: 5,
                divisions: 10,
                label: _nota.toString(),
                activeColor: Colors.amber,
                inactiveColor: Colors.grey,
                onChanged: (value) {
                  setState(() {
                    _nota = value;
                  });
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _salvarFilme,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Salvar Filme',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
