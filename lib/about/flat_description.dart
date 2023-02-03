import 'package:flutter/material.dart';

class FlatDescription extends StatefulWidget {
  const FlatDescription({super.key});

  @override
  State<FlatDescription> createState() => _FlatDescriptionState();
}

class _FlatDescriptionState extends State<FlatDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flat'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Center(),
    );
  }
}
