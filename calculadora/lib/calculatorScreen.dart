import 'package:calculadora/EnterDataScreen.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() {
    return _StateCalculatorScreen();
  }
}

class _StateCalculatorScreen extends State<CalculatorScreen> {
  int valorX = 0;
  int valorY = 0;

  Future<void> _navigateEnterDataScreen(
      BuildContext context, String varName) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EnterDataScreen(varName: varName)),
    );

    if (!mounted) return;

    setState(() {
      if (varName == "X") {
        valorX = result ?? 0;
      } else if (varName == "Y") {
        valorY = result ?? 0;
      }
    });

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Valor de $varName: $result'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('X: $valorX'),
            TextButton(
              onPressed: () => _navigateEnterDataScreen(context, "X"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade400,
                  minimumSize: const Size(140, 40)),
              child: const Text(
                "Informar X",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Y: $valorY'),
            TextButton(
              onPressed: () => _navigateEnterDataScreen(context, "Y"),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade400,
                  minimumSize: const Size(140, 40)),
              child: const Text(
                "Informar Y",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            int resultado = valorX + valorY;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Resultado'),
                content: Text('A soma de X e Y é: $resultado'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  )
                ],
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade400,
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            "Calcular",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}
