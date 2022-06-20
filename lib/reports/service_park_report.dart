
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ServiceParkReports extends StatefulWidget {
  const ServiceParkReports({Key? key}) : super(key: key);

  @override
  State<ServiceParkReports> createState() => _ServiceParkReportsState();
}

class _ServiceParkReportsState extends State<ServiceParkReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Park Reports'),
        backgroundColor: Colors.lime,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('serviceparkreports').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map<Widget>((document) {
                return Card(
                    child: SizedBox(
                        child: Column(
                          children: document.data()!.entries
                              .map<Widget>((mapEntry) => SizedBox(
                              child: ListTile(
                                title: Text("${mapEntry.key.toString()}: ${mapEntry.value.toString()}"),
                              )))
                              .toList(),
                        )));
              }).toList(),
            );

          }
      )
    );
  }
}
