
import 'package:flutter/material.dart';


class StageReviewReports extends StatefulWidget {
  const StageReviewReports({Key? key}) : super(key: key);

  @override
  State<StageReviewReports> createState() => _StageReviewReportsState();
}

class _StageReviewReportsState extends State<StageReviewReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stage Review Reports'),
      ),
    );
  }
}
