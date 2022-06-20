

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MarshallDeliveryReviews extends StatefulWidget {
  const MarshallDeliveryReviews({Key? key}) : super(key: key);

  @override
  State<MarshallDeliveryReviews> createState() => _MarshallDeliveryReviewsState();
}

class _MarshallDeliveryReviewsState extends State<MarshallDeliveryReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marshall Delivery Reviews'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('supplierdeployment').snapshots(),
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
                        ListTile(title: Text("Stage: ${document['Stage']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ))),
                        ListTile(title: Text("Number of Vip Toilets: ${document['Number of Vip Toilets']}")),
                        ListTile(title: Text(
                            "VIP Toilet Feedback: ${document['VIP Toilet Feedback']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            )
                        )),
                        ListTile(title: Text("Number of Regular Toilets: ${document['Number of Regular Toilets']}")),
                        ListTile(title: Text(
                            "Regular Toilet Feedback: ${document['Regular Toilet Feedback']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ))),
                        ListTile(title: Text("Number of Disabled Toilets: ${document['Number of Disabled Toilets']}")),
                        ListTile(title: Text(
                            "Disabled Toilet Feedback: ${document['Disabled Toilet Feedback']}",
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
