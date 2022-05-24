import 'package:flutter/material.dart';

class LitterMapsPage extends StatelessWidget {
  const LitterMapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Litter Marking Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
