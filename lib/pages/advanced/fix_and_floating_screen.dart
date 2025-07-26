import 'package:flutter/material.dart';

class FixAndFloatingScreen extends StatelessWidget {
  const FixAndFloatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SizedBox()),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Colors.purple),
                  onPressed: () {},
                  child: Wrap(
                    children: [
                      Text('Hitung Simulasi'),
                      Icon(Icons.chevron_right)
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
