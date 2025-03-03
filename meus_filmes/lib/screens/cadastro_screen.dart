import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastroScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilmeAdicionado;
  final Map<String, dynamic>? filme;

  CadastroScreen({required this.onFilmeAdicionado, this.filme});

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

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _tituloController.text = widget.filme!['titulo'];
      _anoController.text = widget.filme!['ano'].toString();
      _direcaoController.text = widget.filme!['direcao'];
      _resumoController.text = widget.filme!['resumo'];
      _urlController.text = widget.filme!['url_cartaz'];
      _nota = widget.filme!['nota'];
    }
  }

  void _salvarFilme() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> novoFilme = {
        'titulo': _tituloController.text,
        'ano': int.parse(_anoController.text),
        'direcao': _direcaoController.text,
        'resumo': _resumoController.text,
        'url_cartaz': _urlController.text,
        'nota': _nota,
      };

      if (widget.filme != null) {
        novoFilme['id'] = widget.filme!['id'];
        widget.onFilmeAdicionado(novoFilme);
      } else {
        widget.onFilmeAdicionado(novoFilme);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.filme != null ? 'Editar Filme' : 'Adicionar Filme',
          style: TextStyle(color: Colors.white),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o título do filme';
                  } else if (value.length < 3) {
                    return 'O título deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o ano de lançamento';
                  } else if (int.tryParse(value) == null) {
                    return 'Por favor, insira um ano válido';
                  } else {
                    int year = int.parse(value);
                    if (year < 1900 || year > currentYear) {
                      return 'O ano deve ser entre 1900 e o ano atual ($currentYear)';
                    }
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o diretor do filme';
                  } else if (value.length < 3) {
                    return 'O nome do diretor deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe um resumo do filme';
                  } else if (value.length < 10) {
                    return 'O resumo deve ter pelo menos 10 caracteres';
                  }
                  return null;
                },
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
                  widget.filme != null ? 'Atualizar Filme' : 'Salvar Filme',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
