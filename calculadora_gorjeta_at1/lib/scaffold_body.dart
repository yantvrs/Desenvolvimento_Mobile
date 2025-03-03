import 'package:flutter/material.dart';

class ScaffoldBody extends StatefulWidget {
  const ScaffoldBody({super.key});

  @override
  State<ScaffoldBody> createState() => _ScaffoldBodyState();
}

class _ScaffoldBodyState extends State<ScaffoldBody> {
  TextEditingController _valorController = TextEditingController();

  double _resultado = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void calculaGorjeta() {
    setState(() {
      double valor = double.tryParse(_valorController.text) ?? 0.0;

      const double gorjetaPorcentagem = 10.0;

      double gorjeta = valor * (gorjetaPorcentagem / 100);
      double total = valor + gorjeta;

      _resultado = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/tips.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: _valorController,
              onChanged: (value) => calculaGorjeta(),
              decoration: InputDecoration(
                hintText: "Digite o valor da conta",
                prefixIcon: Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          Text(
            "R\$ ${_resultado.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
