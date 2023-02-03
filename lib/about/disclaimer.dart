import 'package:flutter/material.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({super.key});

  @override
  State<Disclaimer> createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disclaimer'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Center(),
    );
  }
}
