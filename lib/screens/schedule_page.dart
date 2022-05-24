import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safari Rally 2022 Schedule'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
