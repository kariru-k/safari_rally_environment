

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/locations.dart';

class SupplierReportStagePage extends StatelessWidget {
  const SupplierReportStagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Safari Rally 2022 Stage Maps'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index)
            {
              Locations location = locations[index];
              return Card(
                child: ListTile(
                  title: Text(location.title.toString()),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => SupplierReviewReports(location))
                    );
                  },
                ),
              );
            }
        )
    );
  }
}


class SupplierReviewReports extends StatelessWidget {
  final Locations location;
  const SupplierReviewReports(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title.toString()),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('supplierdeployment').where("Stage", isEqualTo: location.title).snapshots(),
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
                      children: [
                        ListTile(title: Text("Stage: ${document['Stage']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ))),
                        ListTile(title: Text("Number of Vip Toilets: ${document['Number of Vip Toilets']}")),
                        ListTile(title: Text("VIP Toilet Feedback: ${document['VIP Toilet Feedback']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ))),
                        ListTile(title: Text("Number of Regular Toilets: ${document['Number of Regular Toilets']}")),
                        ListTile(title: Text("Regular Toilet Feedback: ${document['Regular Toilet Feedback']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ))),
                        ListTile(title: Text("Number of Disabled Toilets: ${document['Number of Disabled Toilets']}")),
                        ListTile(title: Text("Disabled Toilet Feedback: ${document['Disabled Toilet Feedback']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ))),
                        ListTile(title: Text("Time Deployed: ${document['timestamp'].toDate()}")),
                        ListTile(title: Text("Submitted by: ${document['submitted by']}",
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
