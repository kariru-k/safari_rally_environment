

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NoiseTestReports extends StatefulWidget {
  const NoiseTestReports({Key? key}) : super(key: key);

  @override
  State<NoiseTestReports> createState() => _NoiseTestReportsState();
}

class _NoiseTestReportsState extends State<NoiseTestReports> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noise Test Reports'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      //collect noise test data from firebase and display it in a table
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('noisetestdata').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: SizedBox(
                  child: Column(
                    children: [
                      ListTile(title: Text("Car Number: ${document['Car Number']}")),
                      ListTile(title: Text("Driver Name: ${document['Driver Name']}")),
                      ListTile(title: Text("Co-Driver Name: ${document['Co-Driver Name']}")),
                      ListTile(title: Text("Car Make: ${document['Car Make']}")),
                      ListTile(title: Text("Car Model: ${document['Car Model']}")),
                      ListTile(title: Text("Rally Category: ${document['Rally Category']}")),
                      ListTile(title: Text("Sound Test (0.5m): ${document['Sound Test 1']}")),
                      ListTile(title: Text("Sound Test 1 Compliance: ${document['Sound Test 1 Compliance']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ))),
                      ListTile(title: Text("Sound Test 2 (2m): ${document['Sound Test 2 (2m)']}")),
                      ListTile(title: Text("Sound Test 2 Compliance: ${document['Sound Test 2 Compliance']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ))),
                      ListTile(title: Text("Sound Test 3 (5m): ${document['Sound Test 3 (5m)']}")),
                      ListTile(title: Text("Sound Test 3 Compliance: ${document['Sound Test 3 Compliance']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ))),
                    ],
                  )
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
