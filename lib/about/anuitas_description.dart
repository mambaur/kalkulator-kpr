import 'package:flutter/material.dart';

class AnuitasDescription extends StatefulWidget {
  const AnuitasDescription({super.key});

  @override
  State<AnuitasDescription> createState() => _AnuitasDescriptionState();
}

class _AnuitasDescriptionState extends State<AnuitasDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anuitas'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Center(),
    );
  }
}
