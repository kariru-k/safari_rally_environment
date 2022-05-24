import 'package:flutter/material.dart';

class NoisePage extends StatelessWidget {
  const NoisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Test Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}

