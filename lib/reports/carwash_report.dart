

import 'package:flutter/material.dart';

class CarWashReports extends StatefulWidget {
  const CarWashReports({Key? key}) : super(key: key);

  @override
  State<CarWashReports> createState() => _CarWashReportsState();
}

class _CarWashReportsState extends State<CarWashReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Wash Reports'),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
    );
  }
}
