import 'package:flutter/material.dart';

class EnterDataScreen extends StatelessWidget {
  const EnterDataScreen({super.key, required this.varName});

  final String varName;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preenche Valores"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Set $varName:"),
            SizedBox(
              width: 250,
              child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Digite um valor",
                    hintStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                  )),
            )
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            int enteredValue = int.tryParse(controller.text) ?? 0;
            Navigator.pop(context, enteredValue);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey.shade400,
            minimumSize: const Size(150, 50),
          ),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
