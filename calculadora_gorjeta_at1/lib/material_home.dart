import 'package:flutter/material.dart';
import 'package:flutter_application_1/scaffold_body.dart';

class MaterialHome extends StatelessWidget {
  const MaterialHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 234, 131, 131),
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: const Text(
              'Calcula Gorjeta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 189, 236, 182),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: const ScaffoldBody(),
      ),
    );
  }
}
