import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safari Rally 2022 Stage Maps'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
