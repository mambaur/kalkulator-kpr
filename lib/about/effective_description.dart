import 'package:flutter/material.dart';

class EffectiveDescription extends StatefulWidget {
  const EffectiveDescription({super.key});

  @override
  State<EffectiveDescription> createState() => _EffectiveDescriptionState();
}

class _EffectiveDescriptionState extends State<EffectiveDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Effective'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      body: Center(),
    );
  }
}
