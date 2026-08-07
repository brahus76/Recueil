import 'package:flutter/material.dart';

void main(){
  runApp(
      const RecueilApp()
  );
}
class RecueilApp extends StatelessWidget{
  const RecueilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Recueil"),
        ),
        body: Center(
          child: const Text("Recueil - en Instruction"),
        ),
      ),
    );
  }
}