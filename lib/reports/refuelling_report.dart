
import 'package:flutter/material.dart';


class RefuellingReports extends StatefulWidget {
  const RefuellingReports({Key? key}) : super(key: key);

  @override
  State<RefuellingReports> createState() => _RefuellingReportsState();
}

class _RefuellingReportsState extends State<RefuellingReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refuelling Reports'),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
    );
  }
}
